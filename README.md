```

version: '3.8'

services:
  mongodb-backup-s3:
    image: excelazmin/mongodb-backup-s3:latest
    environment:
      - ACCESS_KEY_ID=Your Key ID
      - SECRET_ACCESS_KEY= Your Access Key
      - BUCKET_NAME=backups
      - BUCKET_DIR=mongodb-dump
      - INIT_BACKUP=true
    deploy:
      labels:
        - "swarm.cronjob.enable=true"
        - "swarm.cronjob.schedule=0 0 * * *"
        - "swarm.cronjob.skip-running=true"
      replicas: 0
      restart_policy:
        condition: none
    command: /bin/bash -c "/backup_script.sh"
    networks:
      - mongodb_replica_network

networks:
  mongodb_replica_network:
    name: mongodb_replica_network
    external: true

```
