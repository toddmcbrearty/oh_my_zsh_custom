<?php
$arti = "~/Code/giftogram/api";
try {
  echo " php $arti/artisan --version";
  $result = exec("php $arti/artisan --version");

} catch (Exception $e) {
  echo "Error: " . $e->getMessage();
  exit(1);
}
echo $result;

//preg_match('/^Laravel\sFramework\s([0-9]{2}.[0-9]{1,2}.[0-9]{1,2})$/', $result, $versions);
//print_r($versions);
