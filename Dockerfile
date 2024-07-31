# Imagen base de Node.js
FROM arm64v8/node:18

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar el archivo .env al directorio de trabajo
COPY .env .env

# Instalar OpenSSH
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

# Configurar SSH para escuchar en el puerto 2222
RUN sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config

# Configurar SSH
RUN echo 'root:Col202x' | chpasswd 
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
# Copiar un script que maneje la clonación
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Puertos de escucha de tu aplicación
EXPOSE 3000
# Exponer el puerto 2222 para SSH
EXPOSE 2222
# Ejecutar el script de configuraciones iniciales
CMD ["/entrypoint.sh"]

