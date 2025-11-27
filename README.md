# Practica Server con Docker
Sistema de práctica con contenedores Docker (MariaDB + PHP/Apache)

Este sistema configura un entorno listo para que varias maquinas puedan acceder
a una **interfaz web** que consulta datos desde una base de datos **MariaDB**
corriendo dentro de un contenedor de Docker.

Se utiliza un stack **LAMP simplificado** (Linux + Apache + PHP + MariaDB) montado con 'docker-compose'.

## Requisitos
Antes de iniciar, asegúrate de tener instalado en tu equipo:
	•	Docker Desktop (Windows, Mac o Linux)
	•	Git (para clonar el repositorio)

Puedes verificar que Docker funciona con:
docker --version
docker compose version

## Pasos

1. Clonar el repositorio
git clone https://github.com/tu-usuario/tu-repo.git
cd tu-repo

2. Levantar los contenedores
docker compose up -d

Esto levantará tres servicios:
	•	db – MariaDB 11
	•	web – Servidor Apache + PHP
	•	phpmyadmin – Panel para administrar la base de datos

Al iniciarse, MariaDB ejecutará automáticamente el archivo db/init.sql
para crear la base de datos, tablas, datos ejemplo, procedimiento y trigger.

3. Acceder a los servicios
➤ Interfaz web (Apache + PHP)
http://localhost:8080

➤ phpMyAdmin (administración de la BD)
http://localhost:8082

Credenciales:
	•	Usuario: root
	•	Password: root
	•	Host: db

 4. Estructura del proyecto
 .
├── docker-compose.yml
├── db/
│   └── init.sql          # Script que crea BD, tablas, inserts, procedimiento y trigger
├── web/
│   ├── index.php         # Página principal
│   ├── add_pedido.php    # Inserción de pedidos mediante SP
│   ├── (cualquier otro archivo .php)
└── README.md

5. Detener contenedores
Cuando termines:
docker compose down

Esto detiene y elimina los contenedores, pero no borra los datos, ya que están en un volumen Docker.

6. Reiniciar el sistema después
Simplemente vuelve a levantar los servicios:
docker compose up -d

## Acceso desde otras computadoras en la red (LAN)

	1.	Todas las computadoras deben estar conectadas al mismo switch/router.
	2.	El servidor debe compartir su IP local (ejemplo: 192.168.0.15).
	3.	Los demás integrantes acceden así:
        http://IP_DEL_SERVIDOR:8080
        http://IP_DEL_SERVIDOR:8082

Para conocer tu IP en Mac/Linux:
ipconfig getifaddr en0

En Windows:
ipconfig
