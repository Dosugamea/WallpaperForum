from bottle import route, run,response,request, static_file,hook
from bottle import TEMPLATE_PATH,template,redirect,HTTPResponse,error
from datetime import datetime
from SQLer import SQLer
import json,os,sqlite3,random,glob

def js_resp(jsdata):
    r = HTTPResponse(status=200, body=json.dumps(jsdata,ensure_ascii=False))
    r.set_header('Content-Type', 'application/json')
    r.set_header('Access-Control-Allow-Origin','*')
    return r
def chk_User():
    unm = request.get_cookie("account",secret="chinochan-mofumofu-shitai")
    if unm == None or unm == "": unm = "ログイン"
    return unm
TEMPLATE_PATH.append("./template")

# Render Static Files
@route('/static/<filename:path>')
def render_static(filename):
    return static_file(filename, root="./static/")
@route('/upload/<filename:path>')
def render_upload(filename):
    return static_file(filename, root="./upload/")
@route('/<filename>.html')
def render_html(filename):
    return template(filename,login=chk_User())
@route('/robots.txt')
def render_robot():
    return static_file("robots.txt", root="./template/")
@error(404)
#@error(500)
def error404_500(error):
    return "404 NotFound"
    
# Render Pages
@route('/index.html')
@route('/')
def index():
    conn = SQLer()
    imgs = conn.do("SELECT * from creations ORDER BY ID ASC LIMIT 100")
    t_ranks = conn.do("SELECT Name,COUNT(Name) from Tags GROUP BY Name ORDER BY COUNT(Name) DESC LIMIT 20")
    u_ranks = conn.do("SELECT Artist,SUM(View) from Creations GROUP BY Artist ORDER BY SUM(View) DESC LIMIT 20")
    conn.close()
    t_ranks = " ".join(["<a href='search.html?t=%s'>%s(%s)</a>"%(d[0],d[0],d[1]) for d in t_ranks])
    u_ranks = " ".join(["<a href='search.html?u=%s'>%s</a>"%(d[0],d[0]) for d in u_ranks])
    imgs = random.sample([d[0] for d in imgs],9)
    return template("index",login=chk_User(),imgs=imgs,u_ranks=u_ranks,t_ranks=t_ranks)
@route('/search.html')
def search():
    return template("search",login=chk_User())
@route('/user.html')
def user():
    unm = chk_User()
    if unm == "ログイン": redirect("/index.html")
    conn = SQLer()
    art_cnt = conn.do("SELECT COUNT(*) FROM `creations` where Artist = '%s'"%(unm))
    if art_cnt == False: art_cnt = 0
    else: art_cnt = art_cnt[0][0]
    view_cnt = conn.do("SELECT SUM(View) FROM `creations` where Artist = '%s'"%(unm))
    if view_cnt not in [False,None]: view_cnt = 0
    else: view_cnt = view_cnt[0][0]
    #ランキングごり押し解決
    ranking = conn.do("SELECT Artist,SUM(View) from Creations GROUP BY Artist ORDER BY SUM(View) DESC LIMIT 100")
    cr = -1
    for i,r in enumerate(ranking):
        if r[0] == unm:
            cr = i + 1
            break
    if cr == -1:cr = "圏外"
    else: cr = str(cr) + "位"
    return template("user",login=chk_User(),art_cnt=art_cnt,view_cnt=view_cnt,current_rank=cr)
@route('/detail/<filename:int>.html')
def detail(filename):
    unm = chk_User()
    if unm == "ログイン": redirect("../login.html")
    conn = SQLer()
    datas = conn.do("SELECT * FROM creations where ID = %s"%(filename))
    if datas in [[],False,None]:
        conn.close()
        redirect("../index.html")
    title = datas[0][1]
    info = datas[0][2]
    artist = datas[0][3]
    datas = conn.do("SELECT * FROM tags where ID = %s"%(filename))
    tags = []
    for d in datas:
        tags.append(d[1])
    tags = ",".join(tags)
    view = 1
    conn.close()
    return template("detail",login=unm,title=title,artist=artist,tag=tags,info=info,view=view,pid=filename)
    
# Process APIs
@route('/api/list',method='GET')
def api_list():
    page,sort,user,tag,sc = request.query.p,request.query.s,request.query.u,request.query.t,request.query.c
    if page == "": page = 1
    else: page = int(page)
    if sort == "": sort = 0
    else: sort = int(sort)
    sdict = {0:"ID",1:"Title",2:"Artist",3:"View"}
    if sort in sdict: sort = sdict[sort]
    else: sort = "ID"
    if sc == "0": sc= "ASC"
    elif sc == "1": sc= "DESC"
    else : sc = "ASC" 
    print(sort)
    print(sc)
    conn = SQLer()
    #通常検索
    if user == "" and tag == "":
        datas = conn.do("SELECT * from creations ORDER BY %s %s LIMIT 10 offset %s"%(sort,sc,(page-1)*10))
        cnts = conn.do("SELECT COUNT(*) from creations ORDER BY %s %s"%(sort,sc))
    #ユーザー名とタグを指定して検索
    elif user != "" and tag != "":
        datas = conn.do("SELECT ID,Title,Info,Artist,View from creations natural left join tags where Name='%s' and Artist='%s' ORDER BY %s %s LIMIT 10 offset %s"%(tag,user,sort,sc,(page-1)*10))
        cnts = conn.do("SELECT COUNT(*) from creations natural left join tags where Name='%s' and Artist='%s' ORDER BY %s %s"%(tag,user,sort,sc))
    #ユーザー名を指定して検索
    elif user != "":
        datas = conn.do("SELECT * from creations where Artist= '%s' ORDER BY %s %s LIMIT 10 offset %s"%(user,sort,sc,(page-1)*10))
        cnts = conn.do("SELECT COUNT(*) from creations where Artist= '%s' ORDER BY %s ASC"%(user,sort))
    #タグを指定して検索
    else:
        datas = conn.do("SELECT ID,Title,Info,Artist,View from creations natural left join tags where Name='%s' ORDER BY %s %s LIMIT 10 offset %s"%(tag,sort,sc,(page-1)*10))
        cnts = conn.do("SELECT COUNT(*) from creations natural left join tags where Name='%s' ORDER BY %s %s"%(tag,sort,sc))
    conn.close()
    datas.append(["Cnt",cnts[0][0]]) 
    return js_resp(datas) 
@route('/api/upload',method="POST")
def api_upload():
    unm = chk_User()
    if unm == "ログイン": redirect("../login.html")
    try:
        title = request.forms.get('title')
        info = request.forms.get('info')
        tag = [x.strip() for x in request.forms.get('tag').split(',')]
        upload = request.files.get('data','')
        dt = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        filename,ext = os.path.splitext(upload.filename)
        if ext not in ('.jpg','.JPEG','.PNG','.JPG','.jpeg','.png','.gif'):
            raise ValueError("ファイル拡張子が非対応です")
        upload.save("./upload/")
        conn = SQLer()
        conn.do("INSERT INTO creations (`Title`, `Info`, `Artist`, `View`) VALUES ('%s', '%s', '%s', '%s')"%(title,info,unm,0),fetch=False)
        lid = conn.do("SELECT LAST_INSERT_ID() FROM creations")
        if tag != ['']:
            for t in tag:
                conn.do("INSERT INTO tags (`Name`,`ID`) VALUES ('%s',%s);"%(t,lid[0][0]),fetch=False)
        conn.close()
        os.rename("./upload/%s%s"%(filename,ext),"./upload/%s.png"%(lid[0][0]))
        redirect("../index.html")
    except Exception as e:
        return str(e)
@route('/api/login',method="POST")
def api_login():
    username,password = request.forms.user,request.forms.get('pass')
    conn = SQLer()
    conn.cur.execute('SELECT name FROM users where name=%s and password=%s',(username,password))
    user = conn.cur.fetchall()
    conn.close()
    if user != []:
        response.set_cookie("account", user[0][0], secret="chinochan-mofumofu-shitai",path='/',max_age=2678400)
        redirect("../index.html")
    else:
        redirect("../login.html")
@route('/api/logout',method="GET")
def api_logout():
    response.set_cookie("account", "", secret="chinochan-mofumofu-shitai",path='/',max_age=2678400)
    redirect("../index.html")

run(host='localhost', port=8080, debug=True)