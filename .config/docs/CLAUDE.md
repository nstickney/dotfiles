# Claude Code Context

This file provides context for Claude Code when working in stick's home directory.

## Dotfiles Management

This home directory is managed as a bare git repository for dotfiles, following the [StreakyCobra method](https://news.ycombinator.com/item?id=11071754).

### Key Details

- The bare repo is located at `$HOME/.dotfiles/`
- The working tree is `$HOME`
- Use the `dots` alias to interact with the dotfiles repository
- The `.gitignore` has a `*` rule that matches everything, so you **must** use `-f` or `--force` when adding files

### The `dots` Alias

```bash
alias dots='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

**Important:** When using Claude Code's Bash tool, the `dots` alias is not available in the non-interactive shell. Always use the full git command:

```bash
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME <command>
```

### Examples

```bash
# Check dotfiles status
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME status

# Add a file (note the -f flag is required)
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME add -f .config/sway/config

# Commit changes
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME commit -m "message"

# View diff
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME diff
```

See `.config/docs/README.md` for full documentation.

