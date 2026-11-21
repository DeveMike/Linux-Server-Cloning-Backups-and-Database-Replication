# Week 4 - Server cloning, backups and replication

Server B is made from a snapshot of server A.
B backs up A's website every hour and copies A's database with MariaDB replication.

Server A: http://195.148.21.19/viikko2/
Server B: http://195.148.21.99/viikko4/

## Files

- backup/backup-www.sh - backup script
- deploy/root-crontab.txt - cron for the backup (every hour)
- config/60-replication-A.cnf - MariaDB settings on A
- config/60-replication-B.cnf - MariaDB settings on B
- app/app.py - app on B that only reads the counter
- app/templates/index.html - B's page and documentation
- deploy/viikko4.service - systemd service for the app
- deploy/nginx-default-B - nginx config on B
