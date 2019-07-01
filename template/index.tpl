<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>自然派壁紙掲示板</title>
<link rel="shortcut icon" href="/static/favicon.ico">
<link rel="stylesheet" href="/static/style.css">
</head>
<body>
<div id="titleBox">
    <a href="index.html" style="text-decoration:none; color:#000000;">
    <div id="title">
        <font size="10px">自然派壁紙掲示板</font>
    </div>
    </a>
    <div id="center_box">
        <div id="menuBox">
            % if login == "ログイン":
            <div class="menuBtn"><a href="login.html">ログイン</a></div>
            % else:
            <div class="menuBtn"><a href="user.html">{{! login}}</a></div>  
            % end
            <div class="menuBtn"><a href="help.html">ヘルプ</a></div>
            <div class="menuBtn"><a href="search.html">検索</a></div>
        </div>
    </div>
</div>
<div id="wrapper" style="overflow: auto;">
    <div id="left">
        <div id="news">
         <font size="4px">更新情報</font><br>
         <p>2018/07/27 <a href="/detail/3.html" target="_parent">新たな壁紙</a>が追加されました</p>
         <p>2018/07/15 <a href="/detail/2.html" target="_parent">新たな壁紙</a>が追加されました</p>
         <p>2018/07/10 <a href="/detail/1.html" target="_parent">新たな壁紙</a>が追加されました</p>
         <p>2018/07/01 ホームページを開設しました</p>
        </div>
        <br>
        <!-- ギャラリーテーブル -->
        <div id="table_wrap">
        <table border width="95%" height="95%" align="center">
            <!-- 1列目 -->
            <tr>
                <th><a href="/detail/{{! imgs[0]}}.html"><img src="/upload/{{! imgs[0]}}.png" width="100%"></a></th>
                <th><a href="/detail/{{! imgs[1]}}.html"><img src="/upload/{{! imgs[1]}}.png" width="100%"></a></th>
                <th><a href="/detail/{{! imgs[2]}}.html"><img src="/upload/{{! imgs[2]}}.png" width="100%"></a></th>
            </tr>
            <!-- 2列目 -->
            <tr>
                <th><a href="/detail/{{! imgs[3]}}.html"><img src="/upload/{{! imgs[3]}}.png" width="100%"></a></th>
                <th><a href="/detail/{{! imgs[4]}}.html"><img src="/upload/{{! imgs[4]}}.png" width="100%"></a></th>
                <th><a href="/detail/{{! imgs[5]}}.html"><img src="/upload/{{! imgs[5]}}.png" width="100%"></a></th>
            </tr>
            <!-- 3列目 -->
            <tr>
                <th><a href="/detail/{{! imgs[6]}}.html"><img src="/upload/{{! imgs[6]}}.png" width="100%"></a></th>
                <th><a href="/detail/{{! imgs[7]}}.html"><img src="/upload/{{! imgs[7]}}.png" width="100%"></a></th>
                <th><a href="/detail/{{! imgs[8]}}.html"><img src="/upload/{{! imgs[8]}}.png" width="100%"></a></th>
        </table>
        </div>
    </div>
    <div id="right">
        <br>
        <div id="tag_list">
        <b>人気タグ</b>
            <div id="tags">
                {{! t_ranks}}
            </div>
        </div>
        <br>
        <div id="user_list">
        <b>人気ユーザー</b>
            <div id="users">
                {{! u_ranks}}
            </div>
        </div>
    </div>
</div>
<footer>
2018 自然派壁紙掲示板
</footer>
</body>
</html>