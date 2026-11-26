# Local LLM Guide (Ollama + Docker)

A practical reference for the models currently pulled into your Ollama Docker container, tailored for an **NVIDIA RTX 3080 (10 GB VRAM) + 32 GB System RAM** desktop setup.

---

## 1. Installed Models & Best Use Cases

| Model | Size | Type | Best For | VRAM / Performance Notes |
| :--- | :--- | :--- | :--- | :--- |
| **`gemma4:12b`** | 8.0 GB | Multimodal (Text + Vision) | Complex reasoning, deep analysis, nuanced writing, and detailed image understanding | **Heavyweight:** Fits in 10 GB VRAM with short-to-medium context; long conversations or large images will spill KV cache into system RAM and slow down. |
| **`gemma4:e4b`** | 6.6 GB | Multimodal (Edge-Tuned) | Daily multimodal tasks, screenshot/photo analysis, fast general assistance | **Sweet Spot (Vision + Speed):** Leaves comfortable VRAM headroom on 10 GB GPUs while retaining strong multimodal capability. |
| **`qwen3.5:9b`** | 6.6 GB | Text / Coding / Reasoning | Shell scripting, Python/Bash debugging, structured data extraction, technical Q&A | **Sweet Spot (Coding & Logic):** Fits 100% in 10 GB VRAM with room for context; fast and reliable for developer workflows. |
| **`qwen3.5:4b`** | 3.3 GB | Text / Fast General | Quick terminal lookups, drafting, summarization, running alongside games/ComfyUI | **Daily Speedster:** Very low VRAM footprint, fast token generation, minimal impact on other GPU tasks. |
| **`phi3:latest`** | 2.2 GB | Lightweight Text | Smoke testing, ultra-low-resource background tasks, offline fallback | **Legacy Light:** Fast and tiny, though `qwen3.5:4b` is generally stronger for modern general/coding prompts. |

---

## 2. Quick Selection Cheat Sheet

* **Writing or debugging Bash/Python/Docker configs:** `qwen3.5:9b`
* **Analyzing screenshots, diagrams, or camera photos:** `gemma4:e4b` (fast) or `gemma4:12b` (maximum detail)
* **Quick questions while gaming, editing, or running ComfyUI:** `qwen3.5:4b`
* **Deep brainstorming, long explanations, or tough logic problems:** `gemma4:12b`

---

## 3. Essential Ollama Docker Commands

### Run an Interactive Chat Session
```bash
docker exec -it ollama ollama run qwen3.5:9b
```
*(Type `/bye` inside the chat prompt to exit, or `/?` to see slash commands like `/set`, `/clear`, and `/show`).*

### Check Installed Models
```bash
docker exec -it ollama ollama list
```

### Verify GPU Offload & VRAM Usage
Run this while a model is loaded to verify it is running `100% GPU` instead of spilling onto the CPU:
```bash
docker exec -it ollama ollama ps
```

### Unload a Model to Free VRAM Immediately
Useful before launching games, OBS recording, or ComfyUI:
```bash
docker exec -it ollama ollama stop gemma4:12b
```

### Pull or Update a Model
```bash
docker exec -it ollama ollama pull qwen3.5:9b
```

### Remove an Unused Model
```bash
docker exec -it ollama ollama rm phi3:latest
```

---

## 4. Docker & Performance Tips (10 GB VRAM)

1. **Watch Context Window Size (`num_ctx`):**
   Larger context windows increase KV cache VRAM usage. On an 8.0 GB model like `gemma4:12b`, keeping default context sizes prevents layer spillover into system RAM.
2. **Don't Overlap Heavy GPU Workloads:**
   Unload `6.6 GB`–`8.0 GB` models (`ollama stop <model>`) before running ComfyUI workflows or demanding games so they don't compete for your 10 GB VRAM.
3. **Keep Persistent Storage Mounted:**
   Ensure your container mounts a persistent volume to `/root/.ollama` so updating or recreating the Ollama container never wipes your downloaded model weights.
4. **Auto-Unload Idle Models (`OLLAMA_KEEP_ALIVE`):**
   By default, Ollama keeps a model in VRAM for 5 minutes after your last prompt. You can adjust this in your Docker environment (e.g., `OLLAMA_KEEP_ALIVE=2m` or `10m`) depending on how frequently you switch between terminal AI tasks and GPU-heavy apps.
5. **Useful Shell Aliases (`~/.bashrc`):**
   ```bash
   alias ai='docker exec -it ollama ollama run qwen3.5:9b'
   alias ai-fast='docker exec -it ollama ollama run qwen3.5:4b'
   alias ai-vision='docker exec -it ollama ollama run gemma4:e4b'
   alias ai-ps='docker exec -it ollama ollama ps'
   alias ai-ls='docker exec -it ollama ollama list'
   ```