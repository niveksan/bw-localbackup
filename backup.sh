#!/bin/sh

# rm any backups older than 30 days
find /backups/* -mtime +30 -exec rm {} \;

# create backup filename
BACKUP_FILE="db.sqlite3_$(date "+%F-%H%M%S")"
BACKUP_FILE_ATT="attachments_$(date "+%F-%H%M%S")"

# use sqlite3 to create backup (avoids corruption if db write in progress)
sqlite3 /db.sqlite3 ".backup '/tmp/db.sqlite3'"

# tar up backup
# Funktionierte bisher so:
# tar cvzf /backups/${BACKUP_FILE}.tar.gz /tmp/db.sqlite3

# TESTEN - gehe in /tmp und erstelle dann das tar von db.sqlite3 - FUNKTIONIERT
tar cvzf /backups/${BACKUP_FILE}.tar.gz -C /tmp db.sqlite3

# TESTEN - Verzeichnis Attachments packen und in /backups legen
tar cvzf /backups/${BACKUP_FILE_ATT}.tar.gz -C /attachments

# cleanup tmp folder
rm -rf /tmp/*