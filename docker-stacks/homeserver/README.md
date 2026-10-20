# Nibiru docker servers for Dummies

Manage your entire stack with a single command from your stack directory (`~/.docker-stacks/homeserver`).

### 1. Start Everything (Background Mode)

```bash
cd ~/.docker-stacks/homeserver
docker compose up -d

```

### 2. Stop Everything

```bash
docker compose down

```

### 3. Check Status of All Services

```bash
docker compose ps

```

### 4. View Live Logs (All or Specific Service)

* **All services:**
```bash
docker compose logs -f

```


* **Single service (e.g., Minecraft):**
```bash
docker compose logs -f minecraft

```



### 5. Restart a Single Service (e.g., after editing configs)

```bash
docker compose restart minecraft

```
