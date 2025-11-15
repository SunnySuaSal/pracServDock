CREATE DATABASE IF NOT EXISTS empresa;
USE empresa;

-- Crear tabla vendedor
CREATE TABLE vendedor (
  id_vendedor INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  porcentaje DECIMAL(5,2),
  salario DECIMAL(10,2)
);

-- Crear tabla cliente
CREATE TABLE cliente (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  ciudad VARCHAR(100),
  tipo_industria VARCHAR(100)
);

-- Crear tabla pedido
CREATE TABLE pedido (
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
(1001, 1, 1, 10), -- Pedido con AbernathyConstruccion por Smith
(1002, 2, 2, 20),
(1003, 3, 1, 15),
(1004, 4, 3, 8),
(1005, 1, 5, 12); -- Pedido con AbernathyConstruccion por Baker




