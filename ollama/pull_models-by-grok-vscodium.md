Setting up VSCodium with local LLMs on your ThinkPad T14s is the final piece of the "Eden" puzzle. Since you are already running **Ollama**, we will connect VSCodium to it using **Continue**—the most powerful open-source AI extension for VS Code/Codium in 2026.

Unlike GitHub Copilot, this setup is **100% private, offline, and free**.

---

### 1. Install the "Continue" Extension
1.  Open **VSCodium**.
2.  Go to the **Extensions** view (`Ctrl+Shift+X`).
3.  Search for **Continue** and click **Install**.
4.  Once installed, you'll see a new "C" icon in your left sidebar.

### 2. Configure Continue to use your Ollama Models
Continue needs to know which of the models you just pulled (Llama, DeepSeek, etc.) to use for **Chat** and which to use for **Autocomplete**.

1.  Click the **Continue** icon in the sidebar.
2.  Click the **Gear icon** (bottom right of the Continue panel) to open `config.json`.
3.  Replace or edit the `models` and `tabAutocompleteModel` sections with this optimized configuration for your **Ryzen 7840U**:

```json
{
  "models": [
    {
      "title": "Llama 3.1 8B (Daily)",
      "provider": "ollama",
      "model": "llama3.1:8b"
    },
    {
      "title": "DeepSeek Coder (Advanced)",
      "provider": "ollama",
      "model": "deepseek-coder-v2"
    }
  ],
  "tabAutocompleteModel": {
    "title": "Qwen 2.5 Coder 7B",
    "provider": "ollama",
    "model": "qwen2.5-coder:7b"
  },
  "embeddingsProvider": {
    "provider": "ollama",
    "model": "nomic-embed-text"
  }
}
```

### 3. Why this specific setup?
* **Chat:** **Llama 3.1** is great for general questions, while **DeepSeek** is your specialist for "hard" coding bugs.
* **Autocomplete:** I set this to **Qwen 2.5 Coder 7B**. In 2026, Qwen is the king of "Fill-In-The-Middle" (FIM). It will ghost-write code as you type with almost zero lag on your Radeon 780M.
* **Embeddings:** Adding `nomic-embed-text` (you can `ollama pull nomic-embed-text`) allows Continue to index your local folder, so you can ask, *"Where is the login logic handled in this project?"*

---

### 4. Essential Shortcuts for your Workstation
Now that you're in VSCodium, memorize these to stay in the "flow":

* **`Ctrl + L`**: Highlight code and send it to the Chat. (Use this to say "Refactor this function").
* **`Ctrl + I`**: Inline Edit. It opens a small box above your code. Type "Add error handling here," and it will rewrite the code in place.
* **`Tab`**: To accept the gray "ghost" text suggested by the autocomplete.

### 5. Troubleshooting the Connection
If Continue says "Failed to fetch":
1.  Make sure Ollama is running: `systemctl status ollama`.
2.  If you are using **Zsh**, ensure your `OLLAMA_HOST` is set to `127.0.0.1:11434` (the default).

---

### **The "Doomsday" Power Move: Indexing your Docs**
If you are working on a specific C library (like `GTK` or `Kernel` headers), you can type `@docs` in the Continue chat and paste a URL to the documentation. Continue will scrape it and store it locally so you can chat with the manual **offline**.
