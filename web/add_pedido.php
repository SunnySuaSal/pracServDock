<?php
$host = 'db';
$user = 'root';
$pass = 'root';
$db = 'empresa';

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
  die("Error de conexion: " . $conn->connect_error);
}

$numero = intval($_POST['numero']);
$id_cliente = intval($_POST['id_cliente']);
$id_vendedor = intval($_POST['id_vendedor']);
$cantidad = intval($_POST['cantidad']);

$result_out = 0;
$stmt = $conn->prepare("CALL crear_pedido(?, ?, ?, ?, @resultado)");
$stmt->bind_param("iiii", $numero, $id_cliente, $id_vendedor, $cantidad);
if (!$stmt) {
  die("Error en la preparacion: " . $conn->error);
}
$stmt->execute();
$stmt->close();

// recuperar salida
$res = $conn->query("SELECT @resultado as resultado");
$row = $res->fetch_assoc();
$res_flag = intval($row['resultado']);

if ($res_flag === 1) {
  echo "Pedido creado correctamente. <a href='index.php'>Regresar</a>";
} else {
  echo "Error al crear pedido. Verifique datos (numero llave primaria debe ser único). <a href='index.php'>Regresar</a>";
}

$conn->close();
?>