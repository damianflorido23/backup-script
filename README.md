# Script de Backup Automático en Bash

Este proyecto contiene un script en Bash diseñado para realizar copias de seguridad automáticas de una carpeta específica, organizarlas por mes y semana, y gestionar tanto los logs como la eliminación de backups antiguos.

---

# Estructura del Proyecto

```
proyecto_backup_script/
├── carpeta_damian/                  # Carpeta original a respaldar
├── backups/                         # Carpeta raíz donde se guardan los backups
│   └── YYYY-MM/semana_NN/           # Estructura de carpetas por mes y semana
│       └── carpeta_damian_YYYY-MM-DD.tar.gz
│
└── backups/logs_backups/           # Carpeta donde se almacenan los logs
    └── backup_YYYY-MM-DD_HH-MM-SS.log
```

---

# ¿Qué hace este script?

1. **Comprime** la carpeta `carpeta_damian` en un archivo `.tar.gz`.
2. **Organiza** los backups en subcarpetas por mes (`YYYY-MM`) y semana (`semana_NN`).
3. **Genera logs** detallados para cada ejecución en `backups/logs_backups`.
4. **Elimina backups** de hace más de **2 meses** automáticamente.
5. **Limpia logs** antiguos con más de **60 días** de antigüedad.

---

# Configuración

Edita estas variables al principio del script `backup.sh` según tus rutas:

```bash
ORIGEN="/ruta/a/la/carpeta_a_respaladar"
RAIZ_BACKUP="/ruta/a/backups"
LOG_DIR="/ruta/a/logs"
```

---

# Cómo usarlo

1. Dale permisos de ejecución al script:

```bash
chmod +x backup.sh
```

2. Ejecuta el script manualmente:

```bash
./backup.sh
```

3. (Opcional) Añádelo al `crontab` para que se ejecute automáticamente:

```bash
crontab -e
```

Agrega una línea como esta para ejecutarlo todos los días a las 2:00 AM:

```bash
0 2 * * * /ruta/completa/a/backup.sh
```

---

# Limpieza automática

- Elimina la carpeta completa de backups de hace **2 meses**.
- Elimina logs con más de **60 días** de antigüedad mediante `find`.

---

# Autor

**Damián Florido**  
Script personalizado para gestión de backups en entornos locales.
