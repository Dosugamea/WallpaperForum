<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>自然派壁紙掲示板　ユーザーページ</title>
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
<div id="wrapper">
<br>
<center>
<font size="5px">ログイン画面</font><br><br>
<form action="/api/login" method="post">
<table style="font-size: 5vw;" border>
    <tr>
        <th>ユーザー名</th><th><input type="text" placeholder="" name="user" style="width:100%;font-size:5vw;"></th>
    </tr>
    <tr>
        <th>パスワード</th><th><input type="text" placeholder="忘れたら諦めてください" name="pass" style="width:100%;font-size:5vw;"></th>
    </tr>
</table>
<br>
<input type="submit" value="送信" style="width:30vw; height:15vh; font-size:5vw;">
</form>
</div>
</center>
<footer>
2018 自然派壁紙掲示板
</footer>
</body>
</html>