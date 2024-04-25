#!/bin/bash
# Configuración inicial de mc (asumiendo que tienes las variables de entorno configuradas para acceso)
mc alias set minio http://${MINIO_SERVER}:${PORT} ${ACCESS_KEY} ${SECRET_KEY} >/dev/null 2>&1

# Bucle infinito
while true; do
    start_time=$(date +%s)

    # Eliminar el archivo local si existe para evitar conflictos
    if [ -f "./input.csv" ]; then
        rm ./input.csv >/dev/null 2>&1
    fi

    # Intentar descargar el archivo
    if mc cp minio/${MINIO_BUCKET}/input.csv ./input.csv >/dev/null 2>&1; then
        # Eliminar el archivo del bucket
        if mc rm minio/${MINIO_BUCKET}/input.csv >/dev/null 2>&1; then
            # Ejecutar el script de Python y permitir que su salida vaya a stdout
            python3 ./procesamiento.py
        fi
    fi

    end_time=$(date +%s)
    elapsed=$(( end_time - start_time ))
    sleep_time=$(( 60 - elapsed > 0 ? 60 - elapsed : 0 ))
    
    # Esperar un minuto ajustado para el tiempo de ejecución del bucle
    sleep $sleep_time
done
