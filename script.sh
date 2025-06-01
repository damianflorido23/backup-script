#!/bin/bash

# Carpeta que deseas respaldar
ORIGEN="/home/damian/Escritorio/Proyectos/proyecto_backup_script/carpeta_damian"

# Carpeta donde se guardan todos los backups
RAIZ_BACKUP="/home/damian/Escritorio/Proyectos/proyecto_backup_script/backups"

# Carpeta donde se guardarán los logs
LOG_DIR="/home/damian/Escritorio/Proyectos/proyecto_backup_script/backups/logs_backups"
mkdir -p "$LOG_DIR"

#Archivo de log por ejecución, con fecha y hora
LOG_FILE="$LOG_DIR/backup_$(date +'%Y-%m-%d_%H-%M-%S').log"


# Nombre base para el archivo de respaldo
NOMBRE_BASE="carpeta_damian"

# Fecha actual (formato YYYY-MM-DD)
FECHA=$(date +%F)

# Mes actual (formato YYYY-MM)
MES_ACTUAL=$(date +%Y-%m)

# Semana del año (01 a 53)
SEMANA=$(date +%U)

# Carpeta destino: backups/2025-06/semana_22/
DESTINO="$RAIZ_BACKUP/$MES_ACTUAL/semana_$SEMANA"

# Nombre final del archivo comprimido
NOMBRE_BACKUP="${NOMBRE_BASE}_${FECHA}.tar.gz"

# Crear directorio destino si no existe

mkdir -p "$DESTINO"

# Elimina ruta completa y guarda solo la carpeta
tar -czf "$DESTINO/$NOMBRE_BACKUP" -C "$(dirname "$ORIGEN")" "$(basename "$ORIGEN")"

# Verificar éxito
if [ $? -eq 0 ]; then
    echo "Backup creado correctamente: $DESTINO/$NOMBRE_BACKUP" >> "$LOG_FILE"
else
    echo "Error al crear el backup" >> "$LOG_FILE"
    exit 1
fi

# Obtener el mes de hace 2 meses (formato YYYY-MM)
MES_HACE_2_MESES=$(date --date="2 months ago" +%Y-%m)

# Carpeta antigua que se eliminará
CARPETA_ANTIGUA="$RAIZ_BACKUP/$MES_HACE_2_MESES"

# Si existe, eliminarla
if [ -d "$CARPETA_ANTIGUA" ]; then
    rm -rf "$CARPETA_ANTIGUA"
    echo "Carpeta eliminada: $CARPETA_ANTIGUA" >> "$LOG_FILE"
else
    echo "No hay carpetas de hace 2 meses para borrar." >> "$LOG_FILE"
fi

# Eliminar logs de mas de 2 meses
find "$LOG_DIR" -type f -name "backup_*.log" -mtime +60 -exec rm -f {} \; -exec echo "Log eliminado: {}" \; >> "$LOG_FILE"
