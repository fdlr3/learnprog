<?

include_once 'logic/ArticleController.php';

if(	isset($_POST['submit']) && isset($_POST['title']) && 
	isset($_POST['content']) && isset($_POST['language']))
	{
	$article = new ArticleController();
	$valid = $article->Add
	(
		$_POST['title'],
		$_POST['content'],
		$_POST['language'],
		1
	);
	if($valid){
		header('Location: article.php?name=' . $_POST['title']);
        exit();
	}
}
?>
<?include 'hf/header.php'?>
<form method="POST">
	<p>Title:</p>
	<input type="text" name="title"/>

	<p>Content:</p>
	<textarea type="text" name="content" rows="10" cols="100" ></textarea>

	<p>Language:</p>
	<select name="language">
		<?
		include_once 'logic/LanguageController.php';
		$lang = new LanguageController();
		$langs = $lang->GetAll();
					
		foreach($langs as &$row) {?>
			<option value="<?echo $row['ID_Lang']?>"><?echo $row['Title']?></option>
		<?} unset($row); ?>
	</select>
	</br></br></br>
	<input type="submit" name='submit' value="Submit"/>
</form>
<?include 'hf/footer.php'?>
