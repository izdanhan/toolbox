podman run -d \
--name jellyfin \
--net=host \
--device /dev/dri:/dev/dri \
-v ~/.config/jellyfin:/config \
-v /mnt/alpha/Videos:/mnt/alpha/Videos:rw \
-v /mnt/beta/Videos:/mnt/beta/Videos:rw \
--restart unless-stopped \
docker.io/jellyfin/jellyfin:latest
