default:
    @just --list

start:
    invar pack export
    invar server start
    docker compose logs --follow

stop:
    invar server stop

restart: stop start

[confirm]
reset-world: stop
    rm -rf server/world server/server.properties

[confirm]
reset-server: reset-world restart
