<?php
session_start();
?>
<!DOCTYPE html>
<html lang="pl">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<title>PROJEKT_ORACLE</title>

		<meta name="author" content="Przemek">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="css/bootstrap.min.css">
		<link rel="stylesheet" href="css/style.css">
	</head>
	
	<body>
<nav class="navbar navbar-dark bg-dark">
  <div class="container-fluid">
      <ul class="nav justify-content-end">
		<li class="nav-item">
						<a class="nav-link active" href="index.php">Ksiazki</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="Autorzy.php">Autorzy</a>
					</li>

					<li class="nav-item">
						<a class="nav-link" href="Filmy.php">Filmy</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="DodajK.php">Dodaj Ksiazke</a>
					</li>

		</ul>
  </div>
</nav>
  
<div class="container-fluid text-center">    
  <div class="row content">
    <div class="col-sm-8"> 
		<h2> Ksiazki </h2>
       <div class="tab-pane" role="tabpanel"> 
	   
			<?php
				$conn = oci_connect('HR','haslo','localhost:1521/KSIAZKIFILMY');
					if(!$conn) 
				{
					$m=oci_error();
					trigger_error(hymlentites($m['message']), E_USER_ERROR);
				}
				
				$cursor1=oci_new_cursor($conn);
				$stid = oci_parse($conn,"begin S_WINGS.WAutorzy(:dane); end;");
				oci_bind_by_name($stid,":dane",$cursor1,-1,OCI_B_CURSOR);
				oci_execute($stid);
				oci_execute($cursor1);
				
				
				
			?>
				<table class="table">
					<thead>
						<tr>
							<th scope="col">ID</th>
							<th scope="col">Imie</th>
							<th scope="col">Nazwisko</th>
							<th scope="col">Data Urodzenia</th>
							<th scope="col">Data Śmierci</th>
						</tr>
					</thead>
					
					<tbody>
						<?php
							while (($row = oci_fetch_array($cursor1, OCI_ASSOC + OCI_RETURN_NULLS)) !=false) {
						?>
						<tr>
							<th scope="row"> <?php echo $row['IDAUTOR']; ?> </th>
							<td><?php echo $row['IMIE'] ?></td>
							<td><?php echo $row['NAZWISKO'] ?></td>
							<td><?php echo $row['URODZONY'] ?></td>
							<td><?php echo $row['ZMARLY'] ?></td>

						</tr>
					<?php
					}
					
					oci_free_statement($stid);
					oci_free_statement($cursor1);
					oci_close($conn);
					?>
					</tbody>
				</table>
		</div>
	</div>
	<div class="col-sm-4 text-center">
		
  </div>
</div>

<footer class="container-fluid text-center">
  
</footer>

	</body>
</html>