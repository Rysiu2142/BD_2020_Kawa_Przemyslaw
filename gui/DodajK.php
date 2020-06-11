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
					<li class="nav-item">
						<a class="nav-link" href="DodajA.php">Dodaj Autora</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="DodajF.php">Dodaj Film</a>
					</li>

		</ul>
  </div>
  </div>
</nav>
  
<div class="container-fluid text-center">    
  <div class="row content">
    <div class="col-sm-8"> 
		<h2> Dodawanie Ksiazki</h2>
       <div class="px-4 py-3" > 
			<form action="DodajKPOST.php" method="POST" Class="text-center">
				<div class="form-group">
					<label>Tytuł</label>
					<input name="Tytul" class="form-control" required>
				</div>
				<div class="form-item">
					<label>Rok Wydania</label>
					<input name="RW" class="form-control" placeholder="YYYY">	
				</div>
				<div class="form-item">
					<label>Orginalny Język</label>
					<input name="OJ" class="form-control">
				</div>
				<div class="form-item">
					<label>ID Autora</label>
					<input name="IDA" class="form-control" placeholder="1,2,3">
				</div>
				<div class="form-item">
					<label>ID Gatunku</label>
					<input name="IDG" class="form-control" placeholder="1,2,3">
				</div>
				<div class="form-item">
					<input name="dead" type="hidden">
					<button class="btn btn-secondary btn-sm">Dodaj</button>
				</div>
			</form>
			<?php
			if(isset($_SESSION['Grrr']))
			  {
				  echo $_SESSION['Grrr'];
				  unset ($_SESSION['Grrr']);

			  }
			  ?>
		</div>
	</div>
	<div class="col-sm-4 text-center">
		<h3> Dane </h3>

			<div class="tab-pane" role="tabpanel"> 
				<?php
					$conn = oci_connect('HR','haslo','localhost:1521/KSIAZKIFILMY');
					if(!$conn) 
					{
					$m=oci_error();
					trigger_error(hymlentites($m['message']), E_USER_ERROR);
					}
					$cursor2=oci_new_cursor($conn);
					$stid = oci_parse($conn,"begin S_WINGS.WAutorzy(:dane); end;");
					oci_bind_by_name($stid,":dane",$cursor2,-1,OCI_B_CURSOR);
					oci_execute($stid);
					oci_execute($cursor2);
				?>
				<table class="table">
					<thead>
						<tr>
							<th scope="col">ID Autora</th>
							<th scope="col">Imie</th>
							<th scope="col">Nazwisko</th>
						</tr>
					</thead>
					
					<tbody>
						<?php
							while (($row = oci_fetch_array($cursor2, OCI_ASSOC + OCI_RETURN_NULLS)) !=false) {
						?>
						<tr>
							<th scope="row"> <?php echo $row['IDAUTOR']; ?> </th>
							<td><?php echo $row['IMIE'] ?></td>
							<td><?php echo $row['NAZWISKO'] ?></td>
						</tr>
					<?php 
					}
					
					?>
					</tbody>
				</table>
					<?php
					
					oci_free_statement($stid);
					oci_free_statement($cursor2);
					
					$cursor3=oci_new_cursor($conn);
					$stid = oci_parse($conn,"begin S_WINGS.WGatunki(:dane); end;");
					oci_bind_by_name($stid,":dane",$cursor3,-1,OCI_B_CURSOR);
					oci_execute($stid);
					oci_execute($cursor3);
					?>
					<table class="table">
					<thead>
						<tr>
							<th scope="col">ID Gatunku</th>
							<th scope="col">Gatunek</th>
						</tr>
					</thead>
					
					<tbody>
						<?php
							while (($row = oci_fetch_array($cursor3, OCI_ASSOC + OCI_RETURN_NULLS)) !=false) {
						?>
						<tr>
							<th scope="row"> <?php echo $row['IDGATUNEK']; ?> </th>
							<td><?php echo $row['NAZWA'] ?></td>
						</tr>
					<?php 
					}
						oci_free_statement($stid);
						oci_free_statement($cursor3);
						oci_close($conn);
					?>
					</tbody>
				</table>
			</div>
		
  </div>
</div>
<div class="row">
		<div class="col-sm-4 text-center">

		</div>
</div>
<footer class="container-fluid text-center">
  
</footer>

	</body>
</html>