# Aliases

This folder stores all **custom shell aliases** for your environment.

- Use this folder to keep aliases consistent across machines.
- Aliases are stored in version control, so you never lose them when reinstalling or switching systems.

## Structure

- `examples/` → Example alias files you can copy and extend.
- `custom_aliases.sh` → Your personal aliases (edit this file).
- `README.md` → This guide.

## Usage

1. Add or edit your aliases in `custom_aliases.sh`.
2. Reload them into your shell:

```bash
source ~/Projects/toolbox/aliases/custom_aliases.sh
```

3. (Optional) Add the following line to your `~/.zshrc` or `~/.bashrc`:

```bash
source ~/Projects/toolbox/aliases/custom_aliases.sh
```

## Related Docs

See also: [Alias Management Workflow](../docs/workflows/alias_management.md)
