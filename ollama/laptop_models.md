# Laptop Ollama models

Your current Ollama setup looks excellent for your **ThinkPad T14s Gen 4** with **Ryzen 7 PRO 7840U** (Radeon 780M iGPU) and **32 GB RAM**:

```
NAME                  ID            SIZE    MODIFIED
gemma3:12b            f4031aab637d  8.1 GB  41 minutes ago
qwen2.5:14b           7cdf5a0187d5  9.0 GB  About an hour ago
gemma2:9b             ff02c3702f32  5.4 GB  About an hour ago
qwen2.5-coder:7b      dae161e27b0e  4.7 GB  2 hours ago
qwen2.5:7b            845dbda0ea48  4.7 GB  2 hours ago
llama3.1:8b           46e0c10c039e  4.9 GB  2 hours ago
llama3.2:3b           a80c4f17acd5  2.0 GB  2 hours ago
```

Total downloaded: ~39 GB — perfect fit, leaving plenty of headroom in your 32 GB RAM for inference (no 70B disasters anymore!).

## Quick ranking & recommendations based on 2026 benchmarks/performance on similar AMD iGPU/CPU laptops

These are pulled from community reports (Reddit/LocalLLaMA, Ollama discussions), hardware tests on Ryzen 7840U/780M, and leaderboard trends for small/medium models. Your iGPU (via ROCm if enabled in Ollama) gives a nice boost on smaller models (~20–50+ t/s possible), while larger ones lean more on CPU (~10–30 t/s).

| Model              | Size (quant) | Est. Speed (your hw) | Strengths (2026 view)                          | Best for                          | Recommendation |
|--------------------|--------------|----------------------|------------------------------------------------|-----------------------------------|----------------|
| **qwen2.5:14b**   | ~9 GB       | 15–30 t/s           | Top-tier reasoning, knowledge, multilingual; often beats larger models in quality | General use, complex questions, research | ★★★★★ (your best all-rounder) |
| **gemma3:12b**    | ~8.1 GB     | 18–35 t/s           | Excellent coherence, math/science focus; strong uncensored feel in many tests | Reasoning, writing, technical tasks | ★★★★☆ (very close 2nd) |
| **qwen2.5:7b**    | ~4.7 GB     | 30–60+ t/s          | Fast, high quality for size; beats many 8–13B in benchmarks | Everyday chat, quick tasks | ★★★★☆ (speed king) |
| **qwen2.5-coder:7b** | ~4.7 GB  | 30–55 t/s           | Specialized coding beast; great autocomplete, debugging | Programming, code explanation | ★★★★☆ (if you code a lot) |
| **llama3.1:8b**   | ~4.9 GB     | 25–45 t/s           | Solid general-purpose baseline; good long-context | Balanced daily driver | ★★★☆☆ (reliable but outshone by Qwen/Gemma) |
| **gemma2:9b**     | ~5.4 GB     | 20–40 t/s           | Good pop-culture/knowledge; predecessor to gemma3 | Casual, creative writing | ★★★☆☆ (use gemma3:12b instead) |
| **llama3.2:3b**   | ~2 GB       | 50–80+ t/s          | Very fast tiny model; surprisingly capable | Ultra-quick responses, low-power | ★★☆☆☆ (backup for speed) |

**Top picks to use right now**:

1. **qwen2.5:14b** → Your flagship. Highest capability without killing speed. Use this for most things — it's frequently called one of the best medium models in 2026 for local hardware.
2. **gemma3:12b** → Switch here for math, science, or when you want super-coherent output. Many users prefer it over Qwen for certain reasoning chains.
3. **qwen2.5-coder:7b** or **qwen2.5:7b** → For fast responses or coding sessions. The 7B variants fly on your setup (often 40–60 t/s on CPU/iGPU).

### Tips for best experience in Open WebUI

- In the model selector (chat or admin > models), pick one and set **temperature 0.7–0.9** for creative, **0.1–0.3** for precise/code.
- If iGPU acceleration isn't active (check `ollama ps` or logs for ROCm mentions), everything runs great on CPU anyway — your 8-core Zen 4 is strong.
- Test context length: These support 8K–128K tokens; set higher in Open WebUI for long chats/codebases.
- Refresh models list in Open WebUI after pulls if needed.

Your collection is already well-balanced — no need for more unless you want a specialized one (e.g., **deepseek-r1:32b** if you crave even stronger reasoning, but it'll be slower ~8–20 t/s). Start chatting with **qwen2.5:14b** today — it's a beast on your laptop!

What are you planning to use it for most (coding, writing, research, fun chats)? I can suggest prompt tweaks or next pulls. Enjoy! 🚀
