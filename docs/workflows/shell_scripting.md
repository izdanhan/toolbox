# Shell Scripting Guide

## Basics
Scripts start with a **shebang**:
```bash
#!/bin/bash
echo "Hello World"
```

Make executable:
```bash
chmod +x script.sh
./script.sh
```

---

## Variables
```bash
name="Alice"
echo "Hello $name"
```

## Loops
```bash
for i in {1..5}; do
  echo "Number $i"
done
```

## Conditionals
```bash
if [ -f file.txt ]; then
  echo "File exists"
else
  echo "Missing file"
fi
```

---

## Functions
```bash
greet() {
  echo "Hi, $1"
}
greet Bob
```

---

## Best practices
- Always use `#!/bin/bash` or `#!/usr/bin/env bash`.
- Quote variables (`"$var"`) to avoid globbing issues.
- Use `set -euo pipefail` for safer scripts.
- Log output for debugging.

