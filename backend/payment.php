<?php
include 'function.php';
header("Access-Control-Allow-Origin: http://localhost:3000");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type");
$details = json_decode(file_get_contents('php://input'));
function trimInputs($val){return trim($val);
} 
$code = trimInputs($details);
$newFunc = new MyFunc;
$newFunc->paymentDetails($code);
?>