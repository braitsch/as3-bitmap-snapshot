<?php

if (isset($GLOBALS["HTTP_RAW_POST_DATA"]))
{
// create the target directory if it doesn't exist //	
	$dir = ($_GET['destination']) ? $_GET['destination'] : 'images';
	if (!file_exists($dir)) mkdir($dir, 0777, true);

// write the file to the target directory //		
	$fp = fopen($dir.'/'.$_GET['filename'], "wb" );
	fwrite( $fp, $GLOBALS[ 'HTTP_RAW_POST_DATA' ] );
	fclose( $fp );	
    echo('ok'); // print any informations clients needed, something like uploaded image url for preview.
}	else{
	echo('file data not received');
}

?>
