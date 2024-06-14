# Docker wordpress

Docker compose de l'api wordpress ainsi que les mécanismes permettant de le manager :
    - Wordpress v6.0.0
    - Wordpress-cli
    - Mariadb - sql
    - Nginx
    - Backup systéme

## Restore

To restore wp-content:
  1. Delete wp-content in wordpress volume if damaged : docker exec -it cms-wordpress rm -rf /var/www/html/wp-content
  1. Copy wp-content backup uncompressed : docker cp <local_backup> cms-wordpress:/var/www/html/

To restore database:
  1. If dump database as created with --add-drop-table : 
         cat <dump.sql> | docker exec -i cms-backup-cron mysql -P 3306 -h 172.18.5.2 -u <user> -p<password> -B <database>
  1. If you want check ip of mariadb container use cmd : docker network inspect nginx-proxy 

Get wp-content manually:
  1. Copy wp-content: docker cp cms-wordpress:/var/www/html/wp-content <local_directory> 

Create dump of database manually:
  1. Enter in backup container: docker exec -it cms-backup-cron /bin/bash
  1. mysqldump -P 3306 -h 172.18.5.2 -u <user> -p<password> -B <database> > /var/www/html/backup/<namedump.sql>
  1. Exit cotnainer: exit
  1. Copy file: docker cp cms-wordpress:/var/www/html/wp-content <local_directory> 
~                                                                                         
