**Yes, that list is obsolete.** That summary was written with a stale 2025/early-2026 baseline disguised as "2026 context." Since then, the local model landscape shifted significantly with **Gemma 4**, **Qwen 3.5 / 3.8**, and **GPT-OSS**.

Running `qwen2.5` or `gemma3` as your primary drivers on an RTX 3080 (10 GB VRAM) is leaving massive performance, native multimodality, and 256K context windows on the table.

### Hardware Reality Check (RTX 3080 10 GB + 32 GB RAM)

* **The Hard Ceiling:** 10 GB VRAM hasn't magically grown. Your strict limit for 100% GPU residency (zero CPU/RAM offloading) remains **~7.5–8.5 GB weights**, leaving ~1.5–2.5 GB for KV cache and CUDA overhead.
* **The Trap in the Old Advice:** The old text tells you `qwen2.5:14b` (~9 GB) is a "perfect fit" with "32K context" and "full GPU offload." False. A 9 GB weight file on a 10 GB card leaves ~1 GB for context. Push context past 4K–8K tokens and the KV cache spills into your DDR4 system RAM over PCIe, tanking token generation speed.

### Current Roster Upgrades (November 2026)

| Old Model | Replacement | Size (Q4) | Why Switch |
| --- | --- | --- | --- |
| **qwen2.5:14b** / **gemma3:12b** | **`gemma4:12b`** | ~7.7–8.0 GB | **New primary driver.** Apache 2.0 license, native vision/audio/thinking, 256K context window, and beats both old models across reasoning and benchmarks while fitting cleaner inside 10 GB VRAM. |
| **qwen2.5:7b** / **qwen2.5-coder:7b** | **`qwen3.5:9b`** | ~6.6–7.6 GB | **New speed/coding/agentic workhorse.** Dense 9B with 256K context. Leaves plenty of VRAM headroom on your 3080 for massive context windows without RAM spillover. |
| **llama3.1:8b** / **gemma2:9b** | **`gemma4:e4b`** | ~6.6–9.5 GB (or ~4.6 GB for `e2b`) | Edge-optimized effective 4B with native vision/audio and thinking. Retire `gemma2` and `llama3.1` immediately—they are dead weight. |
| **llama3.2:3b** | **`qwen3.5:4b`** | ~3.3–4.0 GB | Same ultra-fast tiny footprint, massively smarter, 256K context. |
| **DeepSeek-R1:32b** (Offloaded) | **`deepseek-r1:14b`** or **`deepseek-r1:8b`** | ~9 GB / ~5 GB | Offloading a 32B dense model across PCIe to DDR4 RAM turns your 3080 into a bottleneck. Stick to the 8B (full VRAM) or 14B (minimal offload) distills. |

### Actionable Loadout for Your Desktop

1. **Purge legacy models:** `ollama rm qwen2.5:14b qwen2.5:7b qwen2.5-coder:7b gemma3:12b gemma2:9b llama3.1:8b llama3.2:3b`
2. **Pull current loadout:**
* `ollama pull gemma4:12b` (Heavy general work, multimodal, reasoning — keep context capped around 8K–16K to stay inside VRAM)
* `ollama pull qwen3.5:9b` (Daily driver, coding, fast iteration — plenty of VRAM room for 32K–64K context)
* `ollama pull qwen3.5:4b` (Instant low-latency tasks)


3. **Skip the "30B+ MoE" hype for this specific GPU:** You will see recommendations for `qwen3-coder:30b` (A3B) or `gemma4:26b` (A4B). Even though they only activate 3B–4B parameters per token, the total weights are **16–19 GB**. They will spill half their weights into system RAM on a 10 GB card, destroying your generation speed. Keep your weights under 8.5 GB.
