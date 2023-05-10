<?php
session_start();
$fetched_username = $_GET['username'];
$db = mysqli_connect('localhost', 'root', '', 'parking_management');
if (!$db) {
    echo "Database connection failed";
}

$sql = "SELECT username, name, vehicle, parking_id FROM user_information WHERE username = '" . $fetched_username . "'";
$result = mysqli_query($db, $sql);
$count = mysqli_num_rows($result);
$list = array();

if ($result) {
    while ($row = mysqli_fetch_assoc($result)) {
        $list[] = $row;
    }
    echo json_encode($list);
}
?>