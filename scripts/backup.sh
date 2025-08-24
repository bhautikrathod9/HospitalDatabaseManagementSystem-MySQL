#!/bin/bash

# Database credentials
DB_USER="root"
DB_PASS="your_password"
DB_NAME="hospital_management_system"

# Backup directory
BACKUP_DIR="/path/to/backups"
DATE=$(date +%Y%m%d_%H%M%S)

# Create backup
mysqldump -u $DB_USER -p$DB_PASS $DB_NAME > $BACKUP_DIR/hospital_backup_$DATE.sql

# Keep only last 7 days of backups
find $BACKUP_DIR -name "hospital_backup_*.sql" -mtime +7 -delete

echo "Backup completed: hospital_backup_$DATE.sql"