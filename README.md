# toolbox

A personal collection of **utility scripts, helpers, and documentation** to make working with Linux systems, Git, and development environments more efficient.  
This repo acts as a **toolbox and knowledge base**, keeping all small but useful scripts, cheatsheets, and best practices in one organized and version-controlled location.  

---

## Purpose

- 🚀 Speed up repetitive tasks (system cleanup, repo sync, benchmarking, etc.)  
- 📂 Centralize scripts, aliases, and personal notes in one place  
- 🔄 Keep environments consistent across multiple machines  
- 📝 Serve as a reference library for best practices and troubleshooting  

---

## 📂 Directory Structure

```
toolbox
├── aliases # Centralized shell aliases for consistent environments
│ ├── examples/ # Example alias files to copy/extend
│ └── git_aliases.sh # Git-related aliases (new)
│
├── docs # Documentation: guides, cheatsheets, best practices
│ ├── git/ # Git usage, workflows, and version control tips
│ ├── linux/ # Linux tips, cheatsheets, and references
│ ├── system/ # System administration & security best practices
│ ├── workflows/ # Guides, workflows, and "how-to" documents
│ └── next_steps.md # Living guide: ideas for repo expansion (new)
│
├── ollama # Scripts and helpers for Ollama models
│ └── examples/ # Example prompts, configs, or usage patterns
│
├── system # System utilities
│ ├── benchmarks/ # GPU/CPU/system performance benchmarking
│ ├── cleanup/ # Disk cleanup, log rotation, cache clearing
│ ├── monitoring/ # System monitoring and info scripts
│ └── network/ # Networking utilities (new)
│
├── utils # General-purpose helper scripts
│ ├── backup/ # Backup & restore scripts
│ ├── files/ # File utilities (JSON prettify, rename, search, etc.) (new)
│ ├── timers/ # Stopwatch, countdown, and time-tracking tools
│ └── misc/ # Small utilities that don’t fit elsewhere
│
└── templates # Starter templates for new scripts or docs
├── bash/ # Boilerplate for new Bash scripts
└── markdown/ # Example structure for new documentation
```

---

## Best Practices

- **Consistency is key**  
  Always group similar items in the same folder.  

- **Name things clearly**  
  Use descriptive filenames (`gpu_benchmark.sh`, not `test.sh`).  

- **Write for future you**  
  Add comments and explanations in scripts so they remain useful later.  

- **Expand logically**  
  When multiple related files appear, create a subfolder rather than cluttering.  

- **Sync across systems**  
  Use Git + SSH keys to keep the repo consistent across desktop, laptop, or servers.  

---

### 📝 Repo Maintenance

- **File:** `repo_maintenance.md`  
- **Description:** Lightweight checklist for keeping the `toolbox` repo organized, consistent, and synced across machines.

---

## Example Use Cases

- **System cleanup before a build**  
  ```bash
  ./system/cleanup/cleanup.sh
  ```

- **Run GPU benchmark and log results**  
  ```bash
  ./system/benchmarks/gpu_benchmark.sh
  ```

- **Quick reference for Git setup**  
  ```bash
  less docs/git/git_cheatsheet.md
  ```

- **Backup a directory**  
  ```bash
  ./utils/backup/backup.sh ~/Projects
  ```

---

## 🔄 Repo Sync Workflow
To keep your laptop and desktop in sync, use the included **`sync_repos.sh`** script.  
Detailed instructions are in:

📄 [`docs/workflows/repo_sync.md`](docs/workflows/repo_sync.md)

---

## ⚡ Quick Start Scripts

This repository includes a set of **ready-to-use scripts** so you can get immediate value:  

- **aliases/git_aliases.sh** → Handy Git shortcuts (`gs`, `gpo`, `glog`, etc.).  
- **system/monitoring/disk_usage.sh** → Quick disk usage overview.  
- **system/monitoring/net_usage.sh** → Lightweight network usage monitor.  
- **utils/backup/quick_backup.sh** → One-command backup of any folder with timestamped archive.  
- **templates/python/script_template.py** → Python starter with logging and argparse.  

👉 These are **drop-in tools** — try them right away and expand as you go.  

---

## 🚀 Next Steps

The repository includes a living [Toolbox Roadmap](docs/workflows/toolbox_roadmap.md).  
It outlines ideas for new scripts, docs, and best practices to keep this repo growing in an organized way.  

Use it as a **checklist**:  
- Add scripts you find yourself repeating.  
- Expand docs with workflows and references you actually use.  
- Keep everything structured with folder-level `README.md` files.  

### Where to Add New Things
- **aliases/** → shell alias collections, organized by topic (e.g., git, sysadmin).  
- **docs/** → guides, cheatsheets, and best practices (grouped into subfolders).  
- **ollama/** → scripts, helpers, and examples for Ollama models and prompts.  
- **system/** → benchmarking, cleanup, and monitoring scripts.  
- **utils/** → general-purpose helpers (backup, timers, encryption, etc.).  
- **templates/** → boilerplate code for Bash, Markdown, Python, Docker, etc.  

---



## Folder Conventions

- Every folder contains a `README.md` (or placeholder) to ensure it is tracked in GitHub.  
- This makes the structure consistent and prevents empty folders from disappearing.  
