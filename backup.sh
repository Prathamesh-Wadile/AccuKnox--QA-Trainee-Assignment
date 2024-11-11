#!/bin/bash

# Replace with your specific settings
SOURCE_DIR="/path/to/source/directory"
DESTINATION_DIR="user@remote_server:/path/to/destination/directory"
BACKUP_LOG="/path/to/backup_log.txt"

# Create a timestamp for the backup
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)

# Create the backup directory on the remote server if it doesn't exist
ssh $DESTINATION_DIR "mkdir -p backup_$TIMESTAMP"

# Use rsync to perform the backup
rsync -avz --progress $SOURCE_DIR $DESTINATION_DIR/backup_$TIMESTAMP >> $BACKUP_LOG 2>&1

# Check the exit status of rsync to determine success or failure
if [ $? -eq 0 ]; then
  echo "Backup completed successfully!" >> $BACKUP_LOG
else
  echo "Backup failed!" >> $BACKUP_LOG
fi

