<?php
require('vendor/autoload.php');
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

class MyFunc{
 //Database Connection//
 public function __construct(){
    $servername = $_ENV['SERVERNAME'];
    $username = $_ENV['USERNAME'];
    $password =$_ENV['PASSWORD'];
    $dbname = $_ENV['DBNAME'];
    $this->conn = new mysqli($servername, $username, $password, $dbname); 
    if(!$this->conn){
         die();
      }
    }

// Get user IP address for identification
public function getIp(){
        if(!empty($_SERVER['HTTP_CLIENT_IP'])){
            //ip from share internet
            $ip = $_SERVER['HTTP_CLIENT_IP'];
        }elseif(!empty($_SERVER['HTTP_X_FORWARDED_FOR'])){
            //ip pass from proxy
            $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
        }else{
            $ip = $_SERVER['REMOTE_ADDR'];
        }
        return $ip;
    }

// Generate Random String
public function generateRandomString($length = 10) {
        $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $charactersLength = strlen($characters);
        $randomString = '';
        for ($i = 0; $i < $length; $i++) {
            $randomString .= $characters[rand(0, $charactersLength - 1)];
        }
        return $randomString;
    }

//  Generate Bitcoin Wallet address from blockonomics   
public function generateAddress(){
    $apikey = 'vIP3QaayKEVAB29GJMz4RHua1x5agdBHrDgRZBKRkHk';
    $url = "https://www.blockonomics.co/api/";
    $options = array( 
        'http' => array(
        'header'  => 'Authorization: Bearer '.$apikey,
        'method'  => 'POST',
        'content' => '',
        'ignore_errors' => true
                )   
            );  
            
    $context = stream_context_create($options);
    $contents = file_get_contents($url."new_address", false, $context);
    $object = json_decode($contents);
            
    // Check if address was generated successfully
     if (isset($object->address)) {
              $address = $object->address;
        } else {
            // Show any possible errors
         $address = $http_response_header[0]."\n".$contents;
            }
        return $address;
        }

// Get current BTC  rate 
public function getBTCPrice($currency){
    $content = file_get_contents("https://www.blockonomics.co/api/price?currency=".$currency);
    $content = json_decode($content);
    $price = $content->price;
    return $price;
}

// Convert USD rate to BTC
public function USDtoBTC($productPrice){
    $rate = $this->getBTCPrice("USD");
    return $productPrice/$rate;
}


// Create Invoice  
public function createInvoice($product, $price){
        $code =  $this->generateRandomString(25);
        $address =  $this->generateAddress();
        $status = -1;
        $ip =  $this->getIp();
        $sql = "INSERT INTO `invoice` (`code`, `address`, `price`, `status`, `product`,`ip`) 
        VALUES (?, ?, ?, ?, ?, ?)";
        $stmt = $this->conn->prepare($sql); 
        $stmt->bind_param("ssssss", $code, $address, $price, $status, $product, $ip);
        if($stmt->execute()){
        echo $code;
    }
    
    }

// Get payment details and send to frontend
public function paymentDetails($code){
    $sql = "SELECT * FROM invoice WHERE code = ?";
    $stmt = $this->conn->prepare($sql);
    $stmt->bind_param("s", $code);
    $stmt->execute();
    $res = $stmt->get_result();
    if($res->num_rows > 0){
       $fetchedProduct = $res->fetch_assoc();
       $address = $fetchedProduct['address'];
       $product = $fetchedProduct['product'];
       $status = $fetchedProduct['status'];
       $price = $fetchedProduct['price'];
       $BTCtoUsdPrice = $this->USDtoBTC($price);
       $BTCPrice = $BTCtoUsdPrice;
       $paymentDetails = array('address'=>$address, 'product'=>$product, 'status'=>$status, 'price'=>$BTCPrice);
       echo json_encode($paymentDetails);
    }
}

// Get product price
 public function getProductPrice($address){
    $sql = "SELECT * FROM invoice WHERE address = ?";
    $stmt = $this->conn->prepare($sql);
    $stmt->bind_param("s", $address);
    $stmt->execute();
      $res = $stmt->get_result();
      if($res->num_rows > 0){
       $fetchedProduct = $res->fetch_assoc();
       $price = $fetchedProduct['price'];
       return $price;
    }
 }

 // Get product code
 public function getProductCode($address){
    $sql = "SELECT * FROM invoice WHERE address = ?";
    $stmt = $this->conn->prepare($sql);
    $stmt->bind_param("s", $address);
    $stmt->execute();
      $res = $stmt->get_result();
      if($res->num_rows > 0){
       $fetchedProduct = $res->fetch_assoc();
       $code = $fetchedProduct['code'];
       return $code;
    }
 }

//  Update Invoice Status
 public function updateInvoiceStatus($code, $status){
    $sql = "UPDATE `invoice` SET  `status` = ? WHERE `code` = ?";
    $stmt = $this->conn->prepare($sql); 
    $stmt->bind_param("ss", $status,  $code);
    $stmt->execute();
}

// Update payment table with response from the call back URL
public function updatePayment($txid, $value, $status, $addr){
$sql = "INSERT INTO `payments` (`txid`, `addr`, `value`, `status`) 
VALUES (?, ?, ?, ?)";
$stmt = $this->conn->prepare($sql); 
$stmt->bind_param("ssss", $txid, $addr, $value, $status);
if($stmt->execute()){
$code = $this->getProductCode($addr);
$price = $this->getProductPrice($addr);
$ConvertPrice = $this->USDtoBTC($price);
$ProdPrice = $ConvertPrice*100000000;


// Expired
if($status < 0){
    exit();
}else{
$this->updateInvoiceStatus($code, $status);
}



}
}


}





?>