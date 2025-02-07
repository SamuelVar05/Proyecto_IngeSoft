# Usar una imagen base ligera de Node.js
FROM node:20

# Crear y establecer el directorio de trabajo
WORKDIR /app

# Copiar archivos de dependencias
COPY package*.json ./

# Instalar dependencias de producción
RUN npm install --only=production

# Instalar NestJS CLI globalmente
RUN npm install -g @nestjs/cli

# Copiar el código fuente
COPY . .

# Copiar archivo de variables de entorno
COPY .env.production .env

# Construir la aplicación NestJS
RUN npm run build

# Exponer el puerto en el que se ejecutará la aplicación
EXPOSE 3000

# Comando por defecto para iniciar la aplicación
CMD ["node", "dist/src/main"]

