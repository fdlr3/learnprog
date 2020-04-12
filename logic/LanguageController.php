<?

include_once 'config.php';

class LanguageController {

    function LastID(){
        $database = new MySQLDB();
        $db = $database->getConnection();

        if($db != null){
            $sql = "SELECT MAX(ID_Lang) as maxid FROM Lang;";
            $stmt = $db->prepare($sql);
            $stmt->execute();

            $result = $stmt->fetch();
            return (int)$result['maxid'];
        } else {
            return -1;
        }
    }

    function GetAll(){
        $database = new MySQLDB();
        $db = $database->getConnection();

        $sql = "SELECT * FROM Lang";
        $stmt = $db->prepare($sql);
        $valid = $stmt->execute();

        if($valid){
            return $stmt->fetchAll();
        }
        return null;
    }


}

?>
