<?php 
include 'function.php';

$secretlocal = ""; // Code in the callback, make sure this matches to what youve set

// Get all these values
$status = 0;
$txid = $_GET['txid'];
$value = $_GET['value'];
$status = $_GET['status'];
$addr = $_GET['addr'];
$secret = $_GET['secret'];

// Check all are set
if(empty($txid) || empty($value) || empty($addr) || empty($secret)){
    exit();
}

if($secret != $secretlocal){
    exit();
}

$newFunc = new MyFunc;

$newFunc->updatePayment($txid, $value, $status, $addr);



?>