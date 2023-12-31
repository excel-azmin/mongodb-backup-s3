FROM mongo

# Install necessary packages
RUN apt-get update && apt-get -y install cron awscli

# Set any environment variables needed for the script
ENV MONGODB_HOST=mongodb-master
# Add other MongoDB-related environment variables here

# Set environment variables for Bangladesh timezone
ENV TZ=Asia/Dhaka \
    CRON_TZ=Asia/Dhaka \
    CRON_TIME="0 3 * * *"

# Add your backup script into the image
ADD backup_script.sh /backup_script.sh
RUN chmod +x /backup_script.sh
