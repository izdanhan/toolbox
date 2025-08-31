# 🦙 Ollama Utilities (`ollama/`)

This folder contains scripts and helpers for working with **Ollama models**.  
It provides a structured way to manage prompts, run benchmarks, and keep your AI workflows consistent.

---

## 📂 Structure

```
ollama
├── model_manager.sh   # Script to pull, remove, or list Ollama models
├── ollama_helper.sh   # Utility wrapper for running models with prompts
└── examples/          # Example prompts, configs, and usage patterns
```

---

## 📖 Navigation

- [model_manager.sh](model_manager.sh) → Manage models (pull, remove, list).  
- [ollama_helper.sh](ollama_helper.sh) → Run a model with a given prompt.  
- [examples/](examples/) → Starter prompts and demonstration files.  

---

## 🛠 Best Practices

- **Prompts**:  
  - Keep all prompts inside the `examples/` folder or a dedicated `prompts/` folder.  
  - Use descriptive filenames (e.g., `coding_help.txt`, `linux_guide.txt`).  
  - Store only **plain text** in prompts to avoid format issues.  

- **Models**:  
  - Use `model_manager.sh` to keep models up to date.  
  - Clearly document which model (`llama3.1:8b`, `mistral:7b`, etc.) is used in each workflow.  
  - Prefer lighter models on laptops and heavier ones on desktops with GPUs.  

- **Runs**:  
  - Redirect outputs into log files for reproducibility.  
  - Pair each run with metadata (model, date, prompt used).  
  - Automate repetitive runs with shell scripts.  

---

## 💡 Example Workflows

1. **Pull a model:**  
   ```bash
   ./model_manager.sh pull llama3.1:8b
   ```

2. **List installed models:**  
   ```bash
   ./model_manager.sh list
   ```

3. **Run a prompt with Ollama:**  
   ```bash
   ./ollama_helper.sh examples/example_prompt.txt
   ```

4. **Save output to a log file:**  
   ```bash
   ./ollama_helper.sh examples/example_prompt.txt > logs/ollama_run_$(date +%F).log
   ```

---

This folder is your **AI workflow hub** — scripts here ensure your Ollama usage stays **organized, reproducible, and portable** across machines.
