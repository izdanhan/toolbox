# 🧰 Toolbox

This repository is your **personal toolbox** — a collection of scripts, templates, and documentation designed to keep your workflow consistent, organized, and efficient across systems.

It contains:

- 🔧 Shell aliases  
- 📚 Documentation & guides  
- 🤖 Ollama helpers  
- 🖥 System utilities  
- 🛠 General-purpose scripts  
- 📑 Templates for new files  

---

## 📂 Directory Structure

```
toolbox
├── aliases/       # Centralized shell aliases for consistent environments
│   └── examples/  # Example alias files to copy/extend
│
├── configs/       # Config files
│   └── home/      # Config files in $home/.configs
│
├── docs/          # Documentation: guides, cheatsheets, best practices
│   ├── git/       # Git usage & workflows
│   ├── linux/     # Linux references & tips
│   ├── system/    # Sysadmin & security best practices
│   └── workflows/ # Step-by-step guides & custom workflows
│       └── toolbox_maintenance.md # Guide for maintaining & expanding this repo
│
├── ollama/        # Scripts and helpers for Ollama models
│   └── examples/  # Example prompts, configs, usage patterns
│
├── system/        # System utilities
│   ├── benchmarks/ # GPU/CPU/system performance benchmarking
│   ├── cleanup/    # Disk cleanup, log rotation, cache clearing
│   └── monitoring/ # System monitoring and info scripts
│
├── utils/         # General-purpose helper scripts
│   ├── backup/    # Backup & restore scripts
│   ├── timers/    # Stopwatch, countdown, time tracking
│   └── misc/      # Small utilities that don’t fit elsewhere
│
└── templates/     # Starter templates
    ├── bash/      # Boilerplate for new Bash scripts
    └── markdown/  # Example structure for new documentation
```

---

## 📖 Navigation

- [aliases/](aliases/README.md) → Centralized aliases + examples
- [configs/](configs/README.md) → Config files for programs, mainly in .config folder.  
- [docs/](docs/README.md) → Knowledge base (Git, Linux, system, workflows, incl. [toolbox maintenance](docs/workflows/toolbox_maintenance.md))  
- [ollama/](ollama/README.md) → Model helpers, examples, and scripts  
- [system/](system/README.md) → Benchmarks, cleanup, monitoring tools  
- [utils/](utils/README.md) → Backup, timers, misc utilities  
- [templates/](templates/README.md) → Boilerplate templates for Bash & Markdown  

---

## 🚀 Best Practices

- Keep scripts **small, focused, and self-contained**.  
- Use **folder-level `README.md` files** as quick guides.  
- Store reusable patterns under `templates/`.  
- Add **examples/** folders when showing usage patterns.  
- Expand the `docs/` knowledge base regularly — it should grow over time into your personal “OS manual.”  
- Organize scripts by function (benchmarks, cleanup, monitoring, etc.) so they are discoverable.  

---

## 🧪 Example Use Cases

- Quickly run **GPU vs CPU benchmarks** with `system/benchmarks/gpu_benchmark.sh`.  
- Manage and test **Ollama models** with `ollama/model_manager.sh`.  
- Keep your **aliases synced across machines** with `aliases/custom_aliases.sh`.  
- Document your **workflows and best practices** under `docs/workflows/`.  
- Maintain your toolbox itself with `docs/workflows/toolbox_maintenance.md`.  
- Create new scripts or docs with consistency using `templates/`.  

---

## ⚡ Quick Start

1. Clone the repo:  
   ```bash
   git clone git@github.com:<your-username>/toolbox.git ~/Projects/github/toolbox
   ```

2. Explore scripts:  
   ```bash
   cd toolbox/system/benchmarks
   ./gpu_benchmark.sh
   ```

3. Add your own scripts and docs to the right folder.  

---

## 🔄 Repo Maintenance

- Keep your repo in sync:  
  ```bash
  ./sync_repos.sh
  ```

- Add and commit changes:  
  ```bash
  git add .
  git commit -m "Added new script/docs"
  git push origin main
  ```

---

## 📌 Next Steps

- Expand `docs/` with your own knowledge base (Linux tips, Git workflows, troubleshooting).  
- Add new **aliases** under `aliases/` and sync across systems.  
- Create **templates** for script or document types you use often.  
- Grow this repo into your **go-to toolbox** for all environments.  
- Maintain repo structure and consistency using [toolbox maintenance](docs/workflows/toolbox_maintenance.md).  
