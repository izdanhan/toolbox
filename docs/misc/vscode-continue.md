# $HOME/.continue/config.yaml

name: Coding Qwen Config
version: 1.0.0
schema: v1

models:
  - name: Qwen 2.5 Coder 7B
    provider: ollama
    model: qwen2.5-coder:7b
    roles:
      - chat
      - edit
      - autocomplete
  - name: Llama 3.1 8B
    provider: ollama
    model: llama3.1:8b
    roles:
      - chat
  - name: DeepSeek R1 8B
    provider: ollama
    model: deepseek-r1:8b
    roles:
      - chat

tabAutocompleteModel:
  name: Qwen Autocomplete
  provider: ollama
  model: qwen2.5-coder:7b

embeddingsProvider:
  provider: ollama
  model: llama3.1:8b
