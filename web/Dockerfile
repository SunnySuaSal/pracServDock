FROM php:8.2-apache

# Instalar extension mysqli
RUN docker-php-ext-install mysqli

#Habilitar el modulo rewrite de apache (util para proyectos futuros)
RUN a2enmod rewrite
