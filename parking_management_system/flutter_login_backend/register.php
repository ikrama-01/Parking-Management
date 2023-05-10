<?php
$db = mysqli_connect('localhost', 'root', '', 'parking_management');
if (!$db) {
	echo "Database connection faild";
}
$fullname = $_POST['full_name'];
$username = $_POST['username'];
$email = $_POST['email_addr'];
$password = $_POST['password'];
$phone_no = $_POST['phone_no'];
$licence_plate = $_POST['licence_plate'];
$sql = "SELECT username FROM user_information WHERE username = '" . $username . "'";
$result = mysqli_query($db, $sql);
$count = mysqli_num_rows($result);
if ($count == 1) {
	echo json_encode("Error");
} else {
	$insert = "INSERT INTO user_information(uid, name, username, password, phone, email, vehicle, parking_id)VALUES('','" . $fullname . "','" . $username . "','" . $password . "','" . $phone_no . "','" . $email . "','" . $licence_plate . "','')";
	$insert2 = "INSERT INTO `parking_details` (`pid`,`time`) VALUES ('', current_timestamp())";
	$query = mysqli_query($db, $insert);
	$query2 = mysqli_query($db, $insert2);
	echo shell_exec("python qr_maker.py $licence_plate $phone_no");
	if ($query && $query2) {
		echo json_encode("Success");
	}
}
?>