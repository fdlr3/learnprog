<?include 'hf/header.php'?>
<?
    include_once "logic/ArticleController.php";

    $article = new ArticleController();
    $articles = $article->Get($_GET['name']);

    foreach($articles as &$row){?>
        <a href="article.php?name=<?echo $row['Title']?>">
            <?echo $row['Title']?>
        </a>
        </br>
        <?}
		unset($row);
		?>
<?include 'hf/footer.php'?>
