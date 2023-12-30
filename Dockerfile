FROM mongo

# Install necessary packages
RUN apt-get update && apt-get -y install cron awscli

# Set environment variables for Bangladesh timezone
ENV TZ=Asia/Dhaka \
    CRON_TZ=Asia/Dhaka \
    CRON_TIME="0 3 * * *"

# Copy the script into the container
ADD run.sh /run.sh

# Set the command to execute when the container starts
CMD /run.sh
