<?php

// The file json-rpc.php effectively handles the remote procedure call that takes the 
// PHP cURL code and executes it.
//
require('game_json-rpc.php');

if(function_exists('xdebug_disable')) { xdebug_disable(); }

// This class is what gets called by game-interpreter.html, takes the command to be executed and 
// forms the PHP cURL to execute it against the SWI-Prolog server form submission. It receives 
// the result of the submission and forwards it back to the calling function in the variable
// $server_output. Normally these calls match on keywords before they execute anything but 
// I commented those out since we want everything to be evaluated by the prolog server.
//
class MyCurl {
  public function query($query) {
 
  
	$ch = curl_init();

curl_setopt($ch, CURLOPT_URL,"http://www.versaggi.net:5000/game");
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query(array('command' => $query)));

// return the transfer as a string of the return value of curl_exec() instead of outputting it out directly.
curl_setopt( $ch, CURLOPT_RETURNTRANSFER, true);


$server_output = curl_exec ($ch);
curl_close ($ch);



// Set up the DOM object and load the returning HTML into it.

libxml_clear_errors();
$dom = new DOMDocument();
$dom->loadHTML($server_output);
libxml_clear_errors();

$xpath = new DOMXpath($dom);

$elements = $xpath->query("//p");

//echo "node0: " . $elements->item(0)->nodeValue . "\n";
//echo "node1: " . $elements->item(1)->nodeValue . "\n";
//echo "node2: " . $elements->item(2)->nodeValue . "\n";
echo $elements->item(2)->nodeValue;
echo "\n\n";

//foreach ($elements as $node){
//  echo "\n node: " . $node->nodeValue. "\n";
//}

return array (foo => $node->nodeValue);
 
  }
}

handle_json_rpc(new MyCurl());

?>
