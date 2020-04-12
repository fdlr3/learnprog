<?include 'hf/header.php'?>
<?
	include_once 'logic/LanguageController.php';

	$lang = new LanguageController();
	$langs = $lang->GetAll();
					
	foreach($langs as &$row) {?>
		<a href="lang.php?name=<?echo $row['Title']?>">
			<div>
				<h2><?php echo $row['Title'] ?></h2>
				<span><?php echo $row['Description'] ?></span>
			</div>
		</a>
		<?} unset($row); ?>
<?include 'hf/footer.php'?>
