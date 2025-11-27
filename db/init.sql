CREATE DATABASE IF NOT EXISTS empresa;
USE empresa;

-- Crear tabla vendedor
CREATE TABLE IF NOT EXISTS vendedor (
  id_vendedor INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  porcentaje DECIMAL(5,2),
  salario DECIMAL(10,2)
);

-- Crear tabla cliente
CREATE TABLE IF NOT EXISTS cliente (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  ciudad VARCHAR(100),
  tipo_industria VARCHAR(100)
);

-- Crear tabla pedido
CREATE TABLE IF NOT EXISTS pedido (
  numero INT PRIMARY KEY,
  id_cliente INT,
  id_vendedor INT,
  cantidad INT,
  FOREIGN KEY(id_cliente) REFERENCES cliente(id_cliente),
  FOREIGN KEY(id_vendedor) REFERENCES vendedor(id_vendedor)
);

-- Insertar datos de ejemplo
INSERT INTO vendedor (nombre, porcentaje, salario) VALUES
('Smith', 50, 35000),
('Jones', 55, 42000),
('Clark', 48, 30000),
('Adams', 60, 50000),
('Baker', 52, 33000);

INSERT INTO cliente(nombre, ciudad, tipo_industria) VALUES
('AbernathyConstruccion','Denver', 'Construccion'),
('MetalWorks', 'Dallas', 'Industrial'),
('GreenFoods', 'Seatle', 'Alimentos'),
('MegaCorp', 'Boston', 'Corporativo');

INSERT INTO pedido (numero, id_cliente, id_vendedor, cantidad) VALUES
(1001, 1, 1, 10),
(1002, 2, 2, 20),
(1003, 3, 1, 15),
(1004, 4, 3, 8),
(1005, 1, 5, 12);

-- ======================================
-- PROCEDIMIENTO: crear_pedido
-- Inserta un nuevo pedido y devuelve 0 o 1 según éxito.
-- Parámetros: p_numero, p_id_cliente, p_id_vendedor, p_cantidad
-- ======================================
DELIMITER $$
CREATE PROCEDURE crear_pedido(
  IN p_numero INT,
  IN p_id_cliente INT,
  IN p_id_vendedor INT,
  IN p_cantidad INT,
  OUT p_result INT
)
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    -- en caso de error devuelve 0
    SET p_result = 0;
  END;

  INSERT INTO pedido (numero, id_cliente, id_vendedor, cantidad)
  VALUES (p_numero, p_id_cliente, p_id_vendedor, p_cantidad);

  SET p_result = 1;
END$$
DELIMITER ;

-- ======================================
-- TRIGGER: after insert on pedido
-- Al insertar un pedido aumenta el salario del vendedor
-- fórmula ejemplo: aumento = cantidad * 10 * (porcentaje/100)
-- ======================================
DELIMITER $$
CREATE TRIGGER after_insert_pedido
AFTER INSERT ON pedido
FOR EACH ROW
BEGIN
  UPDATE vendedor
  SET salario = salario + (NEW.cantidad * 10 * (porcentaje/100))
  WHERE id_vendedor = NEW.id_vendedor;
END$$
DELIMITER ;