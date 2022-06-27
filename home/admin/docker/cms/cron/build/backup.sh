DATEVAR="date +%Y%m%d"

mysqldump -P 3306 -h cms-mariadb -u $MYSQL_USER -p$MYSQL_PASSWORD -B $MYSQL_DB > "/var/www/html/backup/w    ordpress_dump_$($DATEVAR).sql"
tar -zcvf "/var/www/html/backup/wp-content_backup_$($DATEVAR).tar.gz" /var/www/html/wp-content
find /var/www/html/backup/* -mtime +1 -exec rm {} \;
chown -R $BACKUP_USER /var/www/html/backup/

for filename in var/www/html/backup/*
    do  
        echo $filename
    done;