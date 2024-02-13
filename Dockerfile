FROM mongo
# Install necessary packages
RUN apt-get update && apt-get -y install cron awscli
# Add your backup script into the image
ADD backup_script.sh /backup_script.sh
RUN chmod +x /backup_script.sh