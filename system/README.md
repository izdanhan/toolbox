# ⚙️ System Utilities (`system/`)

This folder contains scripts and tools for managing, monitoring, and maintaining your system.  
It is divided into **functional areas** to keep things organized and easy to extend.

---

## 📂 Structure

```
system
├── benchmarks/   # Tools to measure GPU/CPU/system performance
├── cleanup/      # Scripts for disk cleanup, log rotation, cache clearing
└── monitoring/   # Scripts for monitoring system health and resources
```

---

## 📖 Navigation

- [benchmarks/](benchmarks/) → Run performance benchmarks (GPU, CPU, system).  
- [cleanup/](cleanup/) → Free up space, clear caches, and rotate logs safely.  
- [monitoring/](monitoring/) → Collect system info and monitor resource usage.  

---

## 🛠 Best Practices

- **Benchmarks**:  
  - Run on a clean system (minimal background load) for accurate results.  
  - Keep benchmark logs to track performance over time.  
  - Compare across devices (e.g., laptop vs. desktop) for insights.  

- **Cleanup**:  
  - Always review what the script will remove before running.  
  - Automate cleanup with cron/systemd timers, but test first manually.  
  - Keep backups before aggressive cleanup.  

- **Monitoring**:  
  - Use `sysinfo.sh` regularly to spot anomalies early.  
  - Automate monitoring during heavy workloads (e.g., AI model runs).  
  - Store logs if you want historical comparisons.  

---

## 💡 Example Use Cases

- After installing new drivers → run `benchmarks/gpu_benchmark.sh` to compare performance.  
- When `/var/log` or `~/.cache` grows too large → run `cleanup/cleanup.sh` safely.  
- Before a long Ollama run → use `monitoring/sysinfo.sh` to log CPU, RAM, and GPU details.  

---

This folder is your **operations toolkit** for keeping the system fast, clean, and healthy.
