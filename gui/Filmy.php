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
</nav>
  
<div class="container-fluid text-center">    
  <div class="row content">
    <div class="col-sm-8"> 
		<h2> Filmy </h2>
       <div class="tab-pane" role="tabpanel"> 
	   
			<?php
				$conn = oci_connect('HR','haslo','localhost:1521/KSIAZKIFILMY');
					if(!$conn) 
				{
					$m=oci_error();
					trigger_error(hymlentites($m['message']), E_USER_ERROR);
				}
				
				$cursor1=oci_new_cursor($conn);
				$stid = oci_parse($conn,"begin F_Filmy.Fet_Film(:dane); end;");
				oci_bind_by_name($stid,":dane",$cursor1,-1,OCI_B_CURSOR);
				oci_execute($stid);
				oci_execute($cursor1);
				
				
				
			?>
				<table class="table">
					<thead>
						<tr>
							<th scope="col">ID</th>
							<th scope="col">Tytul</th>
							<th scope="col">Na Podstawie</th>
							<th scope="col">Opcje</th>
							<th scope="col">Oceń</th>
						</tr>
					</thead>
					
					<tbody>
						<?php
							while (($row = oci_fetch_array($cursor1, OCI_ASSOC + OCI_RETURN_NULLS)) !=false) {
						?>
						<tr>
							<th scope="row"> <?php echo $row['IDFILM']; ?> </th>
							<td><?php echo $row['TYTUL'] ?></td>
							<td><?php if(isset($row['BOOK'])) { echo $row['BOOK'];} 
										else{ echo "nie określono"; }?></td>
							<td>
								<div class="row text-center">
									<form method="post" action="usunf.php">
										<input name="IDFILM" type="hidden" value="<?php echo $row['IDFILM']; ?>">
										<button name="usun" class="btn btn-warning btm-sm">Usuń</button>
									</form>
									<form method="post" action="Filmy.php">
										<input name="IDFILM1" type="hidden" value="<?php echo $row['IDFILM']; ?>">
										<button name="index" class="btn btn-secondary btm-sm">Szczegóły</button>
									</form>
									
								</div>
							</td>
							<td>
								<div class="row text-center">
								 <form method="post" action="ocenf.php">
										<input name="OCENA" type="number" placeholder="5"> 
										<input name="IDFILM" type="hidden" value="<?php echo $row['IDFILM']; ?>">
										<button name="ocen" class="btn btn-secondary btm-sm">Oceń</button>
									</form>
								</div>
							</td>
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
		<h3> Szczegóły </h3>
    <?php
		if(isset($_POST['IDFILM1'])) 
		{
			$conn = oci_connect('HR','haslo','localhost:1521/KSIAZKIFILMY');
					if(!$conn) 
				{
					$m=oci_error();
					trigger_error(hymlentites($m['message']), E_USER_ERROR);
				}
				$cursor5=oci_new_cursor($conn);
				
				$stid = oci_parse($conn,"begin F_Filmy.AVG_Film(:id,:dane); end;");
					oci_bind_by_name($stid,":dane",$cursor5,-1,OCI_B_CURSOR);
					oci_bind_by_name($stid,":id",$_POST['IDFILM1']);
					oci_execute($stid);
					oci_execute($cursor5);
					
					
		?>
			
			<div class="tab-pane" role="tabpanel"> 
				<h2> Średnia Ocena <h2>
				<h4><?php $row = oci_fetch_array($cursor5,OCI_ASSOC+OCI_RETURN_NULLS);
					if (!empty($row['SREDF']))
					{ 
						echo $row['SREDF'];
					}
					else
						echo "Film Nie ma Ocen";
				?>
				</h4>
				<?php
				 
					oci_free_statement($cursor5);
					$cursor2=oci_new_cursor($conn);
					$stid = oci_parse($conn,"begin F_Kategoria.Fet_Kategoria(:id,:dane); end;");
					oci_bind_by_name($stid,":dane",$cursor2,-1,OCI_B_CURSOR);
					oci_bind_by_name($stid,":id",$_POST['IDFILM1']);
					oci_execute($stid);
					oci_execute($cursor2);
				?>
				<table class="table">
					<thead>
						<tr>
							<th scope="col">ID Kategori</th>
							<th scope="col">Nazwa</th
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
					
					?>

			</div>
		<?php
		unset($_POST['IDKSIAZKA1']);			
		}
		unset($_POST['IDKSIAZKA1']);
		?>
					
    
  </div>
</div>
<div class="row">
		<div class="col-sm-4 text-center">

		</div>
</div>
<footer class="container-fluid text-center">
  <p> Copyright &copy Przemysław Kawa 2020</p>
</footer>

	</body>
</html>