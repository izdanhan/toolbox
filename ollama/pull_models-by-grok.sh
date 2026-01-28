#!/usr/bin/env bash
# pull-good-models.sh
# Pulls recommended Ollama models for Ryzen 7 PRO 7840U + 32 GB RAM laptop (ThinkPad T14s Gen 4)
# Run with: bash pull-good-models.sh    (or chmod +x and ./pull-good-models.sh)
# Models chosen for speed/quality balance in 2026 on your hardware

set -euo pipefail

echo "Starting model pull for Ryzen 7840U / 32 GB setup..."
echo "This may take 10–60 minutes depending on your internet (models are 4–18 GB each)."
echo ""

# Fast & capable daily drivers (7–8B class) – great speed, multilingual
MODELS_FAST=(
  "llama3.2:3b"             # Very fast, good small model baseline
  "llama3.1:8b"             # Excellent general-purpose (Meta's strong 2024/25 base)
  "qwen2.5:7b"              # Top-tier small model – often beats larger ones
  "qwen2.5-coder:7b"        # Best-in-class coding at this size
  "gemma2:9b"               # Google's strong 2025 model – very coherent
)

# Higher quality / reasoning (12–14B class) – best sweet spot for 32 GB
MODELS_GOOD=(
  "qwen2.5:14b"             # Outstanding reasoning & general knowledge
  "gemma3:12b"              # Google's latest – excellent coherence & speed
  # "llama3.1:70b"            # Wait, no – too big; skip or use Q4_K_M if curious but slow
  # Instead: strong MoE alternatives that punch above weight
  # "qwen2.5-coder:32b"       # MoE-style, ~30B but active ~3–8B → great coding/reasoning
)

# Optional: even stronger if you want to push it (may be 15–25 t/s)
MODELS_PUSH=(
  "deepseek-r1:32b"         # Very strong reasoning (distilled variants shine)
  "command-r:35b"           # Cohere's solid long-context model
)

echo "Pulling fast & reliable models first..."
for model in "${MODELS_FAST[@]}"; do
  echo "→ Pulling $model"
  ollama pull "$model"
done

echo ""
echo "Pulling higher-quality / reasoning models..."
for model in "${MODELS_GOOD[@]}"; do
  echo "→ Pulling $model"
  ollama pull "$model"
done

# Uncomment if you want to try the bigger ones (comment out if disk space / time limited)
# echo ""
# echo "Pulling push-the-limits models (optional – slower but very capable)..."
# for model in "${MODELS_PUSH[@]}"; do
#   echo "→ Pulling $model"
#   ollama pull "$model"
# done

echo ""
echo "Done! All pulled models:"
ollama list

echo ""
echo "Recommendations for your setup:"
echo "• Daily / fast: qwen2.5:7b or llama3.1:8b → 30–60+ t/s possible"
echo "• Best quality: qwen2.5:14b or gemma3:12b → ~15–35 t/s, excellent reasoning"
echo "• Coding king: qwen2.5-coder:7b (fast) or :32b (deeper)"
echo "• In Open WebUI: refresh models list after pulling"
echo ""
echo "Tip: If iGPU acceleration works → smaller models fly. If mostly CPU → still very usable."
echo "Enjoy! Let me know which one becomes your favorite."

