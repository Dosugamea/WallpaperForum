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
    <a href="../index.html" style="text-decoration:none; color:#000000;">
    <div id="title">
        <font size="10px">自然派壁紙掲示板</font>
    </div>
    </a>
    <div id="center_box">
        <div id="menuBox">
            % if login == "ログイン":
            <div class="menuBtn"><a href="../login.html">ログイン</a></div>
            % else:
            <div class="menuBtn"><a href="../user.html">{{! login}}</a></div>  
            % end
            <div class="menuBtn"><a href="../help.html">ヘルプ</a></div>
            <div class="menuBtn"><a href="../search.html">検索</a></div>
        </div>
    </div>
</div>
<div id="wrapper">
<br>
<center>
<a href="/upload/{{! pid}}.png" download><img src="/upload/{{! pid}}.png" width="auto" height="150px"></a>
<table border>
    <tr>
        <th>タイトル</th><th>{{! title}}</th>
    </tr>
    <tr>
        <th>作者</th><th>{{! artist}}</th>
    </tr>
    <tr>
        <th>タグ</th><th>{{! tag}}</th>
    </tr>
    <tr>
        <th>閲覧回数</th><th>{{! view}}</th>
    </tr>
</table>
<br>
説明文<br>
{{! info}}
</div>
</center>
<footer>
2018 自然派壁紙掲示板
</footer>
</body>
</html>