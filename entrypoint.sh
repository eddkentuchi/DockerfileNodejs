if [ -z "$GITHUB_TOKEN" ]; then
    echo "Error: GITHUB_TOKEN no está configurado"
    exit 1
fi
echo "Entro a la configuración"

# Clonar archivo
  git clone https://${GITHUB_TOKEN}@github.com/eddkentuchi/PlanningApirestful.git /app/planning
echo "Se clono adecuadamente"
mv /app/.env /app/planning/
echo "Se movio adecuadamente"
# Instalar dependencias
cd /app/planning
npm install
#Iniciar aplicativo
npx pm2 start src/index.js --name planeaciones
npx pm2 log
exec /usr/sbin/sshd -D
#Iniciar ssh
#pm2 start /usr/sbin/sshd --name sshd --interpreter bash -- -D
# PM2 logs
#pm2 logs
