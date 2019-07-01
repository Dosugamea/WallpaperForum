<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>自然派壁紙掲示板 ユーザーページ</title>
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
<font size="5px">{{! login}}さんのユーザーページ</font><br>
合計アップロード数: {{! art_cnt}}枚<br>
閲覧された回数: {{! view_cnt}}回<br>
ランキング: {{! current_rank}}<br>
<br>
<font size="5px">画像をアップロードする</font><br>
<form action="api/upload" method="post" enctype="multipart/form-data">
    <table border>
        <tr>
            <th>作品名</th><th><input type="text" placeholder="かっこいいタイトルを付けてください" name="title" style="width:100%"></th>
        </tr>
        <tr>
            <th>説明文</th><th><textarea name="info" placeholder="あなたの画像のアピールポイントを教えてください" cols="50" rows="10"></textarea></th>
        </tr>
        <tr>
            <th>タグ</th><th><input type="text" name="tag" placeholder="複数入れる場合はカンマで区切ってください" style="width:100%"></th>
        </tr>
        <tr>
            <th>ファイル</th><th><input type="file" name="data"></th>
        </tr>
    </table>
    <input type="submit" value="送信" style="width:15vw; height:6vh;">
</form>
</div>
    <center>
        <font size="5px">ログアウトする</font><br>
        <font size="3px"><u><a href="api/logout">ここをクリック</a></u></font>
    </center>
    <br>
</center>
<footer>
2018 自然派壁紙掲示板
</footer>
</body>
</html>