<?php 
	$db = mysqli_connect('localhost','root','','parking_management');
	$username = $_POST['username'];
	$password = $_POST['password'];
	$sql = "SELECT username, password,vehicle,uid FROM  user_information WHERE username = '".$username."' AND password = '".$password."'";
	$result = mysqli_query($db,$sql);
    $count = mysqli_num_rows($result);
    $list = array();
	$row = mysqli_fetch_assoc($result); 
	$reg_no = $row["vehicle"];
	$uid = $row["uid"];
	    if($result){
        while ($row = mysqli_fetch_assoc($result)) {
            $list[] = $row;
        }
	if ($count == 1) {
		echo json_encode("Success");
	}else{
		echo json_encode("Error");
	}
}
?>