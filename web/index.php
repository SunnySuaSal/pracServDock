<?php
$host = 'db';
$user = 'root';
$pass = 'root';
$db = 'empresa';

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
  die("Error de conexion: " . $conn->connect_error);
}

// Listar vendedores
$vendedores = $conn->query("SELECT * FROM vendedor");

// Listar pedidos
$pedidos = $conn->query("
  SELECT p.numero, c.nombre AS cliente, v.nombre AS vendedor, p.cantidad
  FROM pedido p
  LEFT JOIN cliente c ON p.id_cliente = c.id_cliente
  LEFT JOIN vendedor v ON p.id_vendedor = v.id_vendedor
  ORDER BY p.numero
");
?>
<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Panel Empresa</title>
  </head>
  <body>
    <h1>Vendedores</h1>
    <ul>
    <?php while ($row = $vendedores->fetch_assoc()): ?>
      <li><?php echo htmlspecialchars($row['nombre']) ?> - salario: <?php echo number_format($row['salario'],2) ?></li>
    <?php endwhile; ?>
    </ul>

    <h1>Pedidos</h1>
    <table border="1" cellpadding="6">
      <tr><th>Número</th><th>Cliente</th><th>Vendedor</th><th>Cantidad</th></tr>
      <?php while ($r = $pedidos->fetch_assoc()): ?>
      <tr>
        <td><?php echo htmlspecialchars($r['numero']) ?></td>
        <td><?php echo htmlspecialchars($r['cliente']) ?></td>
        <td><?php echo htmlspecialchars($r['vendedor']) ?></td>
        <td><?php echo htmlspecialchars($r['cantidad']) ?></td>
      </tr>
      <?php endwhile; ?>
    </table>

    <h2>Crear nuevo pedido</h2>
    <form action="add_pedido.php" method="post">
      <label>Número: <input name="numero" required></label><br>
      <label>ID Cliente: <input name="id_cliente" required></label><br>
      <label>ID Vendedor: <input name="id_vendedor" required></label><br>
      <label>Cantidad: <input name="cantidad" required></label><br>
      <button type="submit">Crear pedido</button>
    </form>
  </body>
</html>