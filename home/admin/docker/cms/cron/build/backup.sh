DATEVAR="date +%Y%m%d"

echo " Taskes performed on $($DATEVAR)"

# Dump current database in mariadb docker
echo " - > Dump sql database"
mysqldump -P 3306 -h cms-mariadb -u $MYSQL_USER -p$MYSQL_PASSWORD -B $MYSQL_DB > "/var/www/html/backup/wordpress_dump_$($DATEVAR).sql"

# Archive and zip wp-content
echo " - - > Archive & Zip wp-content"
tar -zcf "/var/www/html/backup/wp-content_backup_$($DATEVAR).tar.gz" --absolute-names /var/www/html/wp-content

# Delete archive older than 1 day
echo " - - - > Delete old archive"
find /var/www/html/backup/* -mtime +1 -exec rm {} \;

# Set www-data ownership for access in wordpress
echo " - - - - > Set correct ownership"
chown -R $BACKUP_USER /var/www/html/backup/

# List all files in backup directory for log
echo " - - - - - > Files saves : "
for filename in $(ls /var/www/html/backup/)
	do
		echo $filename
	done;
