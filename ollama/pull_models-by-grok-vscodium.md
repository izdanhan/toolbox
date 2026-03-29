The **"No models configured"** message in the Continue sidebar usually means the extension cannot properly read or parse your `~/.continue/config.yaml` file.

This is very common after the initial setup, especially if the file is missing the required header or has formatting issues.

### Fix It in 2 Minutes

1. **Open the config file the proper way**:
   - In VS Code, open the Continue sidebar (`Ctrl + L` or click the Continue icon on the left).
   - In the top-right corner of the Continue panel, click the **gear/settings icon**.
   - Choose **"Open config.yaml"** (or "Local Config" → cog icon next to it).

2. **Replace everything** in the file with this clean, minimal working config for your Ollama setup:

```yaml
name: Local Ollama Config
version: 1.0.0
schema: v1

models:
  - name: Qwen2.5 Coder 7B
    provider: ollama
    model: qwen2.5-coder:7b
    apiBase: http://localhost:11434

  - name: Llama 3.2 3B
    provider: ollama
    model: llama3.2:3b
    apiBase: http://localhost:11434

tabAutocompleteModel:
  name: Qwen2.5 Coder 1.5B (Fast Autocomplete)
  provider: ollama
  model: qwen2.5-coder:1.5b
  apiBase: http://localhost:11434
```

3. **Save** the file (`Ctrl + S`).

4. **Refresh Continue**:
   - Close and reopen the Continue sidebar, or restart VS Code completely.
   - In the model dropdown at the top of the Continue chat, you should now see your models listed.

### Quick Test
- Select **Qwen2.5 Coder 7B** in the dropdown.
- Type a prompt like: "Write a Python function to reverse a string" and hit Enter.
- For inline autocomplete while typing code, the 1.5B model should kick in automatically.

### Prerequisites (Double-Check These)
Make sure Ollama is actually running and the models exist:

```bash
# In a terminal
systemctl status ollama          # Should be active (running)
ollama list                      # Should show qwen2.5-coder:7b, llama3.2:3b, qwen2.5-coder:1.5b
```

If any model is missing, pull it first:
```bash
ollama pull qwen2.5-coder:7b
ollama pull qwen2.5-coder:1.5b
ollama pull llama3.2:3b
```
ollama pull llama3.
### If It Still Says "No models configured"
- Restart VS Code.
- Check for YAML formatting errors (indentation must be **2 spaces**, no tabs).
- Open the Developer Tools in VS Code (`Ctrl + Shift + I`) → Console tab and look for Continue-related errors, then paste them here.
- Try the ultra-minimal version (just one model):

```yaml
name: Minimal Ollama
version: 1.0.0
schema: v1

models:
  - name: Qwen Coder
    provider: ollama
    model: qwen2.5-coder:7b
    apiBase: http://localhost:11434
```

Would you like a version optimized for your Ryzen 7840U (with higher context length or temperature settings)? Or do you want to add `@codebase` / edit / apply features?

Paste the exact error (if any) or a screenshot of the Continue panel after trying this config, and I'll refine it further.
