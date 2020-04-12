<?include 'hf/header.php'?>
<?
	include_once "logic/ArticleController.php";

	$article_name = htmlspecialchars($_GET["name"]);
	$article = new ArticleController();
	$cur_article = $article->GetOne($article_name);?>

	<h1><?echo $cur_article["Title"]?></h1>
	</br></br></br>
 	<div><?echo $cur_article["HTML_Content"]?></div>
<?include 'hf/footer.php'?>
