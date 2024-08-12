echo "------Inicio de plano didactico nodejs---------"
if [ -z "$GITHUB_TOKEN" ]; then
    echo "Error: GITHUB_TOKEN no está configurado"
    exit 1
fi
echo "Entro a la configuración"
# Verificar si el directorio /app/planning ya existe
if [ ! -d "/app/planning" ]; then
  # Clonar archivo
  git clone https://${GITHUB_TOKEN}@github.com/eddkentuchi/PlanningApirestful.git /app/planning
  echo "Se clono adecuadamente"
  mv /app/.env /app/planning/
  echo "Se movio adecuadamente"
  # Instalar dependencias
  cd /app/planning
  npm install
else
  echo "El repositorio ya está clonado. Saltando la clonación y la instalación de dependencias."
fi
#Iniciar aplicativo
cd /app/planning
echo "Levantando servicio"
npx pm2 start src/index.js --name planeaciones &
echo "Se levanto el servicio"
npx pm2 log &
echo "Se leventará ssh"
exec /usr/sbin/sshd -D

