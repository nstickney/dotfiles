---
name: clipboard-cmd
description: Copy a terminal command to the user's clipboard using wl-copy. Use this any time you are suggesting or giving the user a command to run in their terminal, instead of just printing it.
allowed-tools: Bash(echo * | wl-copy)
---

When you need to give the user a terminal command to run:

1. Use Bash to pipe the command into `wl-copy` so it lands on their Wayland clipboard
2. Tell the user the command has been copied and they can paste it with Ctrl+V

Example usage:

```bash
echo 'sudo pacman -Syu' | wl-copy
```

For multi-line commands, use a heredoc:

```bash
wl-copy <<'EOF'
command line 1
command line 2
EOF
```

Important:
- Copy the exact command the user should run, nothing extra
- Do NOT wrap the command in backticks or markdown in the copied text
- Always tell the user what command was copied so they can verify before pasting
