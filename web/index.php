<?php
$host = 'db';
$user = 'root';
$pass = 'root';
$db = 'empresa';

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
  die("Error de conexion: " . $conn->connect_error);
}

$result = $conn->query("SELECT * FROM vendedor");

echo "<h1>Vendedores</h1>";
echo "<ul>";

while ($row = $result->fetch_assoc()) {
  echo "<li>" . $row['nombre'] . " - salario: " . $row['salario'] . "</li>";
}

echo "</ul>";

$conn->close();
?>
