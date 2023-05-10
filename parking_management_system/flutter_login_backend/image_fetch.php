<?php
session_start();
$fetched_username = $_GET['username'];
$db = mysqli_connect('localhost', 'root', '', 'parking_management');
if (!$db) {
    echo "Database connection failed";
}

$sql = "SELECT QR FROM user_information WHERE username = '" . $fetched_username . "'";
$result = mysqli_query($db, $sql);
$count = mysqli_num_rows($result);
$list = array();

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $imageData = $row["QR"];
    $encodedImage = base64_encode($imageData);
    header("Content-type: image/jpeg");
    echo $encodedImage;
} else {
    echo "Image not found";
}
?>