FROM debian:bullseye-slim

# Install cron
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        apt-utils cron
    
# Install mariadb-client   
RUN apt-get install -y wget apt-transport-https \
    && wget https://downloads.mariadb.com/MariaDB/mariadb_repo_setup \
    && echo "d4e4635eeb79b0e96483bd70703209c63da55a236eadd7397f769ee434d92ca8  mariadb_repo_setup" \
        | sha256sum -c - \
    && apt-get install -y mariadb-client

# Remove package lists for smaller image sizes
RUN rm -rf /var/lib/apt/lists/*

# Copy and active cron
COPY ./backup.cron /etc/cron.d/backup
RUN chmod 0644 /etc/cron.d/backup \
    && chown root: /etc/cron.d/backup \
    && chmod u+s /usr/sbin/cron \
    && crontab /etc/cron.d/backup \
	&& touch /var/log/cron.log

# Use new entry point wrapper
COPY ./backup-entrypoint.sh /backup-entrypoint.sh
RUN chmod 755 /backup-entrypoint.sh
ENTRYPOINT ["/backup-entrypoint.sh"]