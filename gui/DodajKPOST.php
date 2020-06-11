<?php
	session_start();
	
	if(!isset($_POST['Tytul']))
	{
		header('Location: index.php');
		echo "<script>alert('Error');</script>";
		exit();
	}
	$tytul=$_POST['Tytul'];
	$r=0;
	$conn = oci_connect('HR','haslo','localhost:1521/KSIAZKIFILMY');
		if(!$conn) 
	{
		$m=oci_error();
		trigger_error(hymlentites($m['message']), E_USER_ERROR);
	}

	if(!isset($_POST['RW']))
	{
		$_POST['RW']=NULL;
	}
	if(!isset($_POST['OJ']))
	{
		$_POST['OJ']=NULL;
	}
	
	$cursor1=oci_new_cursor($conn);
			
	$stid = oci_parse($conn,"begin T_Ksiazke.ST_Ksiazki(:tytul, :rok,:jez,:dane); end;");
	oci_bind_by_name($stid,":tytul",$tytul);
	oci_bind_by_name($stid,":rok",$_POST['RW']);
	oci_bind_by_name($stid,":jez",$_POST['OJ']);
	oci_bind_by_name($stid,":dane",$cursor1,-1,OCI_B_CURSOR);
	
	oci_execute($stid);
	oci_execute($cursor1);
	$row = oci_fetch_array($cursor1, OCI_ASSOC + OCI_RETURN_NULLS);
	$idk=$row['IDKSIAZKA'];
	oci_free_statement($stid);
	oci_free_statement($cursor1);
	
	if(isset($_POST['IDA']))
	{
		$stid = oci_parse($conn,"begin T_Ksiazke.ST_KA(:autor,:idk); end;");
		oci_bind_by_name($stid,":idk",$idk);
		$autorzy= explode(",",$_POST['IDA']);
		
		foreach($autorzy as $value)
		{
				if($value!=NULL)
			{
				oci_bind_by_name($stid,":autor",$value);
				oci_execute($stid);
			}
		}
		
		oci_free_statement($stid);
	}
	
	if(isset($_POST['IDG']))
	{
		$stid = oci_parse($conn,"begin T_Ksiazke.ST_KG(:gatunek,:idk); end;");
		oci_bind_by_name($stid,":idk",$idk);
		$gatunki= explode(",",$_POST['IDG']);
		
		foreach($gatunki as $value)
		{
			if($value!=NULL)
			{
			oci_bind_by_name($stid,":gatunek",$value);
			oci_execute($stid);
			}
		}
		
		oci_free_statement($stid);
	}
	
	oci_close($conn);
	header('Location: index.php');
?>