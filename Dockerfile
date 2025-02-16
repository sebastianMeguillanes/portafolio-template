# Usar una imagen base de Python
FROM python:3.10-slim

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar los archivos del proyecto
COPY . .

# Instalar dependencias del sistema (si es necesario)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Crear un entorno virtual (opcional, pero recomendado)
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Instalar Reflex y las dependencias del proyecto
RUN pip install --no-cache-dir reflex

# Inicializar el proyecto Reflex
RUN reflex init

# Instalar dependencias adicionales (si hay un requirements.txt)
RUN if [ -f "requirements.txt" ]; then pip install --no-cache-dir -r requirements.txt; fi

# Exponer el puerto 3000 (puerto por defecto de Reflex)
EXPOSE 3000

# Comando para ejecutar el proyecto
CMD ["reflex", "run"]