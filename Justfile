# List available recipes.
default:
    @just --list

# Refresh `packwiz` and `git` index.
refresh:
    packwiz refresh
    git add .
    git status

# Start the server container.
start:
    docker compose up --detach --build
    docker compose logs --follow

# Stop the server container.
stop:
    docker compose down

# Restart the server container.
restart: stop start

# [no-cd]
# [positional-arguments]
# add IDENTIFIER:
#     #!/usr/bin/env nu
#     def main [
#         --provider: string = "modrinth" # Where to get this asset from?
#         slug: string                    # What mod are you looking for?
#     ] {
#         # Pick a category for the new mod.
#         let category: directory = (ls mods
#             | where type == dir
#             | get name
#             | append (ls resourcepacks
#                 | where type == dir
#                 | get name)
#             | input list --fuzzy "What category does this asset belong to?")

#         packwiz $provider add $slug --meta-folder $category
#         mut metadata: record = open $"($category)/($slug).pw.toml"
#         let new_filename: string = $"../($metadata | get filename)"
#         $metadata.filename = $new_filename
#         $metadata | save --force $"($category)/($slug).pw.toml"
#     }

# Make a full backup of the server.
[no-cd]
backup:
    #!/usr/bin/env nu
    let server_name = (pwd | path basename)
    let backup_name = $server_name + $"_(date now | format date '%Y-%m-%d_%H:%M:%S')"
    cd ..
    cp --recursive $server_name $".backups/($backup_name)"
    sync
    dua .backups
