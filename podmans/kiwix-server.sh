podman run -d \                                                                                                                                      130 ↵
--name kiwix-server \
--restart always \
-p 8080:8080 \
-v ~/.apps/kiwix-zims:/data:rw,Z \
ghcr.io/kiwix/kiwix-serve '*.zim'
