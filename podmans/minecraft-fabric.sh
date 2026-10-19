podman run -d \\
  --name minecraft-fabric \\
  -p 25565:25565 \\
  -e EULA=TRUE \\
  -e VERSION=LATEST \\
  -e TYPE=FABRIC \\
  -v ~/.config/minecraft-fabric:/data:rw \\
  --restart unless-stopped \\
  docker.io/itzg/minecraft-server:latest
  