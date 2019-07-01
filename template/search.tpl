<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>自然派壁紙掲示板</title>
<link rel="shortcut icon" href="/static/favicon.ico">
<link rel="stylesheet" href="/static/style.css">
<script src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
<script src="https://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script src="https://cdn.rawgit.com/botmonster/jquery-bootpag/master/lib/jquery.bootpag.min.js"></script>
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
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
<center>
<font size="6vw">作品一覧</font><br><br>
<style>
th {
    white-space: nowrap;
    overflow:hidden;
    text-overflow: ellipsis;
}
</style>
<table class="table table-condensed table-bordered table-hover table-striped" style="width:98%;">
    <thead>
        <th width="8%"><a href="#" onclick="sort(0); return false;">ID</a></th><th><a href="#" onclick="sort(1); return false;">タイトル</a></th><th>説明文</th><th width="10%"><a href="#" onclick="sort(2); return false;">作者</a></th><th width="13%"><a href="#" onclick="sort(3); return false;">閲覧回数</a></th><th width="10%">リンク</th>
    </thead>
    <tbody id="tdatas">
    <tr><th>1</th><th>Title</th><th>Infos</th><th>Artist</th><th>View</th><th>cnt</th></tr>
    </tbody>
</table>
<div id="page-selection"></div>
<script>
    //URLパラメータ取得
    var getUrlParameter = function getUrlParameter(sParam) {
        var sPageURL = decodeURIComponent(window.location.search.substring(1)),
            sURLVariables = sPageURL.split('&'),
            sParameterName,
            i;

        for (i = 0; i < sURLVariables.length; i++) {
            sParameterName = sURLVariables[i].split('=');

            if (sParameterName[0] === sParam) {
                return sParameterName[1] === undefined ? true : sParameterName[1];
            }
        }
    };
    
    // ソートする
    function sort(type){
        params = new URLSearchParams(location.search.slice(1));
        //昇順 降順
        if (params.get("c") == "1"){
            params.set("c", "0")
        }else if (params.get("c") == "0"){
            params.set("c", "1")
        }else{
            params.set("c", "1")
        }
        params.set("s", type);
        params.delete("p")
        window.location.href = location.pathname + "?" + params;
    }
    
    //テーブルにデータを取得
    function getdatas(num){
        //テーブルを初期化
        $('#tdatas').empty();
        //URLパラメータ取得
        params = new URLSearchParams(location.search.slice(1));
        params.set("p", num);
        var reqURL = "../api/list?"+params;
        //URLを書き換える
        history.pushState(null,null,"/search.html?"+params);
        //HTMLを生成
        $.getJSON(reqURL, function(data){
            $(data).each(function(i,e){
                if (i < data.length -1){
                    $('#tdatas').append(
                        $('<tr></tr>')
                            .append("<td>"+e[0]+"</td>")
                            .append("<td>"+e[1]+"</td>")
                            .append("<td>"+e[2]+"</td>")
                            .append("<td>"+e[3]+"</td>")
                            .append("<td>"+e[4]+"</td>")
                            .append("<td><a href='/detail/"+e[0]+".html'>ここ</td>")
                    );
                }else{
                    return e
                }
            })
        })
    }

    //初回読み込み
    $(function(){
        //テーブルを初期化
        $('#tdatas').empty();
        //URLパラメータ取得
        params = new URLSearchParams(location.search.slice(1));
        var reqURL = "../api/list?"+params;
        //テーブルを生成(TODO: 上と統合。 )
        $.getJSON(reqURL, function(data){
            $(data).each(function(i,e){
                if (i < data.length -1){
                    $('#tdatas').append(
                        $('<tr></tr>')
                            .append("<td>"+e[0]+"</td>")
                            .append("<td>"+e[1]+"</td>")
                            .append("<td>"+e[2]+"</td>")
                            .append("<td>"+e[3]+"</td>")
                            .append("<td>"+e[4]+"</td>")
                            .append("<td><a href='/detail/"+e[0]+".html'>ここ</td>")
                    );
                }else{
                    // init bootpag
                    $('#page-selection').bootpag({
                        total: parseInt(e[1]/10)+1
                    }).on("page", function(event, num){
                         getdatas(num);
                    });
                }
            })
        })
    });
</script>
</div>
<footer>
2018 自然派壁紙掲示板
</body>
</center>
</html>