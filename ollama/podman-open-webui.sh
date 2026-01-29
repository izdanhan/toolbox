podman run -d \
  --name open-webui \
  --network=host \
  -v open-webui:/app/backend/data:Z \
  --restart=unless-stopped \
  ghcr.io/open-webui/open-webui:main
  