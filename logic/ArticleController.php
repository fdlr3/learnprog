<?

include_once 'config.php';

class ArticleController {

    function LastID(){
        $database = new MySQLDB();
        $db = $database->getConnection();

        if($db != null){
            $sql = "SELECT MAX(ID_Article) as maxid FROM Article;";
            $stmt = $db->prepare($sql);
            $stmt->execute();

            $result = $stmt->fetch();
            return (int)$result['maxid'];
        } else {
            return -1;
        }
    }
    
    function Add($title, $content, $language_id, $tag_id){
        $database = new MySQLDB();
        $db = $database->getConnection();

        $sql = "INSERT INTO Article VALUES(NULL, ?, ?, ?, ?, ?)";
        $stmt = $db->prepare($sql);
        $valid = $stmt->execute([
            $title, 
            $content, 
            date('Y-m-d H:i:s'), 
            $language_id, 
            $tag_id]
        );
        if($valid){
            $lastid = $this->LastID();
            if($lastid > 0){
                return true;
            }
        }
        return false;
    }

    function GetOne($name){
        $database = new MySQLDB();
        $db = $database->getConnection();

        $sql = "SELECT * FROM Article WHERE Title = ?";
        $stmt = $db->prepare($sql);
        $valid = $stmt->execute([$name]);

        if($valid){
            return $stmt->fetch();
        }
        return null;
    }

    function Get($lang){
        $database = new MySQLDB();
        $db = $database->getConnection();

        $sql =  "SELECT * FROM Article WHERE FK_Lang = " . 
                "(SELECT ID_Lang FROM Lang WHERE Title = ?);";
        $stmt = $db->prepare($sql);
        $valid = $stmt->execute([$lang]);

        if($valid){
            return $stmt->fetchAll();
        }
        return null;
    }


}

?>
