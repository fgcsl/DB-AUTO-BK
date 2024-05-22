#!/usr/bin/bash

mysqldump="/opt/lampp/bin/mysqldump"
DB_NAME="ttp_icgeb"

BACKUP_DIR="$HOME/data/backups/"

LOCAL_USER="user"
LOCAL_HOST="192.168.5.902"
LOCAL_BASE_DIR="/Data/abhishek/backups/ttp-db/"
LOCAL_CODE_BASE_DIR="/Data/abhishek/backups/ttp-code-file"

#Create the backup
BACKUP_FILE="ttp_backup-$(date +%F-%H.%M.%S).sql"

$mysqldump $DB_NAME  > $BACKUP_DIR/$BACKUP_FILE

# Check if the backup was successful
if [ $? -eq 0 ]; then
    echo "Backup successful, determining the destination folder."

    # Determine the destination based on the current day
    DAY_OF_WEEK=$(date +%u) # 1-7 (Monday(1)-Sunday(7))
    DAY_OF_MONTH=$(date +%d) # 01-31

    if [ "$DAY_OF_MONTH" -eq 23 ]; then
        DEST_DIR="monthly"
    elif [ "$DAY_OF_WEEK" -eq 5 ]; then
        DEST_DIR="weekly"
    else
        DEST_DIR="daily"
    fi

    LOCAL_DIR="$LOCAL_BASE_DIR/$DEST_DIR"
    LOCAL_CODE_DIR="$LOCAL_CODE_BASE_DIR/$DEST_DIR"

    echo "Copying backup to $LOCAL_DIR"

    # Sync the backup file to the local machine
    rsync -avz  --remove-source-files $BACKUP_DIR/$BACKUP_FILE $LOCAL_USER@$LOCAL_HOST:$LOCAL_DIR
    rsync -avzr  /opt/lampp/htdocs/ttp_icgeb $LOCAL_USER@$LOCAL_HOST:$LOCAL_CODE_DIR/ttp_icgeb_$(date +%F-%H.%M.%S)
	

    #For daily backups, keep only the latest 8 backups
    if [ "$DEST_DIR" == "daily" ]; then
        ssh $LOCAL_USER@$LOCAL_HOST "cd $LOCAL_DIR && ls -t | sed -e '1,8d' | xargs -d '\n' rm -rf"
	ssh $LOCAL_USER@$LOCAL_HOST "cd $LOCAL_CODE_DIR && ls -t | sed -e '1,8d' | xargs -d '\n' rm -rf"
    fi


    # Check if the sync was successful
    if [ $? -eq 0 ]; then
        echo "Backup file successfully copied to $LOCAL_DIR."
    else
        echo "Failed to copy the backup file to $LOCAL_DIR."
    fi
else
    echo "Backup failed."
fi

