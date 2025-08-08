DATASET := "wyrm-rpool/srv/mc-servers/exospace"

default:
    @just --list

# Refresh the modpack file, ensuring the server runs the right thing.
update-pack:
    invar pack export
    
# Start the server suite.
start: update-pack
    docker compose up --detach
    docker compose logs --follow

# Stop the server suite.
[confirm]
stop:
    docker compose down

# Backup the server dataset via ZFS.
backup:
    sync
    sudo zfs snapshot {{DATASET}}@`date +%Y%m%d-%H%M%S`-manual

# Restart the server suite.
[confirm]
restart: stop start
