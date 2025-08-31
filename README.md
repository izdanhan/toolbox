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

## Directory Structure

```
misc-scripts
├── aliases              # Centralized shell aliases for consistent environments
│   └── examples/        # Example alias files to copy/extend
│
├── docs                 # Documentation: guides, cheatsheets, best practices
│   ├── git/             # Git usage, workflows, and version control tips
│   ├── linux/           # Linux tips, cheatsheets, and references
│   ├── system/          # System administration & security best practices
│   └── workflows/       # Guides, workflows, and "how-to" documents
│
├── ollama               # Scripts and helpers for Ollama models
│   └── examples/        # Example prompts, configs, or usage patterns
│
├── system               # System utilities
│   ├── benchmarks/      # GPU/CPU/system performance benchmarking
│   ├── cleanup/         # Disk cleanup, log rotation, cache clearing
│   └── monitoring/      # System monitoring and info scripts
│
├── utils                # General-purpose helper scripts
│   ├── backup/          # Backup & restore scripts
│   ├── timers/          # Stopwatch, countdown, and time-tracking tools
│   └── misc/            # Small utilities that don’t fit elsewhere
│
└── templates            # Starter templates for new scripts or docs
    ├── bash/            # Boilerplate for new Bash scripts
    └── markdown/        # Example structure for new documentation
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

## Folder Conventions

- Every folder contains a `README.md` (or placeholder) to ensure it is tracked in GitHub.  
- This makes the structure consistent and prevents empty folders from disappearing.  
