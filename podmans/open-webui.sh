podman run -d \                                                                                                                                      130 ↵
--name open-webui \
--restart always \
-p 3000:8080 \
-e OLLAMA_BASE_URL=http://host.containers.internal:11434 \
-v open-webui:/app/backend/data \
ghcr.io/open-webui/open-webui:main
