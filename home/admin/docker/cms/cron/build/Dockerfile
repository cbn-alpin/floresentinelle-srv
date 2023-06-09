FROM debian:11.7-slim

# Install cron
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        apt-utils cron vim
    
# Install mariadb-client   
RUN apt-get install -y wget apt-transport-https \
    && wget https://downloads.mariadb.com/MariaDB/mariadb_repo_setup \
    && echo "ad125f01bada12a1ba2f9986a21c59d2cccbe8d584e7f55079ecbeb7f43a4da4  mariadb_repo_setup" \
    && apt-get install -y mariadb-client

# Remove package lists for smaller image sizes
RUN rm -rf /var/lib/apt/lists/*

# Copy script for cron
COPY ./backup.sh /usr/local/backup.sh
RUN chmod 755 /usr/local/backup.sh

# Copy and active cron
COPY ./backup.cron /etc/cron.d/backup
RUN chmod 0644 /etc/cron.d/backup \
    && chown root: /etc/cron.d/backup \
    && chmod u+s /usr/sbin/cron \
	&& touch /var/log/cron.log

# Use new entry point wrapper
COPY ./backup-entrypoint.sh /backup-entrypoint.sh
RUN chmod 755 /backup-entrypoint.sh
ENTRYPOINT ["/backup-entrypoint.sh"]
