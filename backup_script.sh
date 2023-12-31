#!/bin/bash

# Assigning environment variables or default values
MONGODB_URI=${MONGODB_URI:-"mongodb://mongodb-master:27017,mongodb-slave1:27017,mongodb-slave2:27017/?replicaSet=mongodb_replica_set"}
BUCKET_NAME=${BUCKET_NAME:-"your-s3-bucket-name"}
REGION=${REGION:-"ap-southeast-1"}
ACCESS_KEY_ID=${ACCESS_KEY_ID:-"your-access-key-id"}
SECRET_ACCESS_KEY=${SECRET_ACCESS_KEY:-"your-secret-access-key"}
ENDPOINT_URL=${ENDPOINT_URL:-"https://s3.ap-southeast-1.amazonaws.com"}
BUCKET_DIR=${BUCKET_DIR:-"mongodb-backups"}

# AWS configuration
export AWS_ACCESS_KEY_ID="${ACCESS_KEY_ID}"
export AWS_SECRET_ACCESS_KEY="${SECRET_ACCESS_KEY}"
export AWS_DEFAULT_REGION="${REGION}"
export AWS_DEFAULT_OUTPUT="json"
export AWS_ENDPOINT_URL="${ENDPOINT_URL}"

# Timestamp for backup name
TIMESTAMP=$(date +"%Y%m%dT%H%M%S")
BACKUP_NAME="${TIMESTAMP}_backup"


perform_backup() {
    # Perform MongoDB backup
    mongodump --uri="${MONGODB_URI}" --gzip --archive="${BACKUP_NAME}.gz"

    echo "Creating backup ..."

    # Upload backup to S3
    aws s3 cp "${BACKUP_NAME}.gz" "s3://${BUCKET_NAME}/${BUCKET_DIR}/${BACKUP_NAME}.gz"

    echo "Push backup ..."

    # Clean up local backup file after uploading to S3
    rm "${BACKUP_NAME}.gz"

    echo "Remove backup file ..."
}


if [ "${INIT_BACKUP}" = true ]; then
    echo "=> Create a backup on startup"
    perform_backup
fi
