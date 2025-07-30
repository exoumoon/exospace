# List available recipes.
default:
    @just --list

# Refresh `invar` and `git` index.
refresh:
    invar pack export
    git add .
    git status

# Start the server container.
start:
    invar server start
    docker compose logs --follow

# Stop the server container.
stop:
    invar server stop

# Restart the server container.
restart: stop start
