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
		<h2> Dodawanie Filmu</h2>
       <div class="px-4 py-3" > 
			<form action="DodajFPOST.php" method="POST" Class="text-center">
				<div class="form-group">
					<label>Tytuł</label>
					<input name="Tytul" class="form-control" required>
				</div>

				<div class="form-item">
					<label>ID Kategoria</label>
					<input name="IDKATEG" class="form-control" placeholder="1,2,3">
				</div>
				<div class="form-item">
					<label>ID Ksiazki</label>
					<input name="IDKSIAZKI" class="form-control" placeholder="Wybierz tylko jeden numer!">
				</div>
				<div class="form-item">
					<input name="dead" type="hidden">
					<button class="btn btn-secondary btn-sm">Dodaj</button>
				</div>
			</form>
			
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
					$stid = oci_parse($conn,"begin S_WINGS.WKategorie(:dane); end;");
					oci_bind_by_name($stid,":dane",$cursor2,-1,OCI_B_CURSOR);
					oci_execute($stid);
					oci_execute($cursor2);
				?>
				<table class="table">
					<thead>
						<tr>
							<th scope="col">ID Kategoria</th>
							<th scope="col">Nazwa</th>
						</tr>
					</thead>
					
					<tbody>
						<?php
							while (($row = oci_fetch_array($cursor2, OCI_ASSOC + OCI_RETURN_NULLS)) !=false) {
						?>
						<tr>
							<th scope="row"> <?php echo $row['IDKATEGORIA']; ?> </th>
							<td><?php echo $row['NAZWA'] ?></td>
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
					$stid = oci_parse($conn,"begin F_Ksiazki.Fet_Ksiazki(:dane); end;");
					oci_bind_by_name($stid,":dane",$cursor3,-1,OCI_B_CURSOR);
					oci_execute($stid);
					oci_execute($cursor3);
					?>
					<table class="table">
					<thead>
						<tr>
							<th scope="col">ID Ksiazki</th>
							<th scope="col">Tytuł</th>
						</tr>
					</thead>
					
					<tbody>
						<?php
							while (($row = oci_fetch_array($cursor3, OCI_ASSOC + OCI_RETURN_NULLS)) !=false) {
						?>
						<tr>
							<th scope="row"> <?php echo $row['IDKSIAZKA']; ?> </th>
							<td><?php echo $row['TYTUL'] ?></td>
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
			<?php
		if(isset($_SESSION['istneje'])) echo $_SESSION['istneje'];
			unset($_SESSION['istneje']); ?>
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