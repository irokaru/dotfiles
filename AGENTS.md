# AGENTS.md

This is a dotfiles repository for personal zsh/starship configuration.

## Project Overview

- Personal shell configuration and package management setup
- Optimized startup performance with lazy loading
- Cross-platform compatibility (macOS/Linux)
- Focus on modern CLI tools: gh, ghq, fzf, starship

## Setup Commands

### Initial Setup

```bash
# Clone the repository
git clone https://github.com/irokaru/dotfiles.git
cd dotfiles

# Run the installation script
./install.sh

# Reload shell
exec zsh
```

### Install Script Details

The `install.sh` script performs:
1. Updates system packages (apt on Linux)
2. Creates symbolic links for configuration files
3. Installs Homebrew if not present
4. Installs all packages defined in Brewfile

### Managing Brewfile

To sync Brewfile with currently installed packages:

```bash
./scripts/brew_dump.sh
```

This will overwrite the Brewfile with your current Homebrew installations. Useful when you install a new package and want to persist it to the dotfiles.

### Verify Setup

```bash
# Reload shell configuration
exec zsh

# Check if all plugins are loaded
zinit list
```

## Key Configuration Files

### zsh/.zshrc
- Main zsh configuration file
- Loads all modules in order: env → zinit → completion → plugins → completions-lazy → fzf → alias
- Sets ZDOTDIR to ~/.config/zsh

### zsh/completion.zsh
- Basic completion setup
- Homebrew site-functions path configuration
- compinit with 24-hour cache optimization

### zsh/completions-lazy.zsh
- Lazy-loaded completions for gh (GitHub CLI)
- Lazy-loaded completions for ghq (Git repository manager)
- Uses zinit turbo mode for performance

### starship/starship.toml
- Cross-platform shell prompt configuration
- Customizable module settings

### Brewfile
- Homebrew package definitions
- Includes: bat, eza, fzf, gh, ghq, git, starship, zinit

### gitconfig
- Git configuration with user settings (irokaru / karuta@nononotyaya.net)
- Default branch: main
- Pull strategy: no rebase
- Useful aliases included

## Development Notes

### Managing Packages

1. Install a new package: `brew install <package>`
2. Update Brewfile: `./scripts/brew_dump.sh`
3. Commit the changes: `git add Brewfile && git commit`

This ensures all team members and systems stay synchronized.

### Adding New Completions

1. If the tool is installed via Homebrew and provides completion files, add to `zsh/completions-lazy.zsh`
2. Use `zinit ice wait lucid` for lazy loading
3. Test with `exec zsh` and verify completion with `<command> <TAB>`

### Modifying Plugins

- Edit `zsh/plugins.zsh` to add/remove zinit plugins
- Reload with `exec zsh` to test

### Optimizing Startup Time

- The .zcompdump cache file is generated in ~/.config/zsh/
- It's gitignored and regenerated daily for performance
- Check .gitignore for excluded files

## Testing Instructions

```bash
# Source the configuration without spawning a new shell
source ~/.config/zsh/.zshrc

# List all loaded zinit plugins
zinit list

# Check if gh completion works
gh <TAB>

# Check if ghq completion works
ghq <TAB>

# Verify fzf integration
Ctrl+R  # Should open fzf history search
```

## Troubleshooting

### Completions not working

1. Verify Homebrew installation: `brew --prefix`
2. Check if completion files exist: `ls $(brew --prefix)/share/zsh/site-functions/`
3. Reload with `exec zsh` and test

### Slow startup

1. Check .zcompdump age: `ls -l ~/.config/zsh/.zcompdump`
2. Delete old cache to force regeneration: `rm ~/.config/zsh/.zcompdump*`
3. Profile startup: `time zsh -i -c exit`

## Security Considerations

- No sensitive data (API keys, tokens) in configuration files
- All secrets should be stored in separate files not tracked by git
- Review Brewfile before running `brew bundle install` to ensure you trust all packages

## Contributing

This is a personal dotfiles repository. Feel free to fork and adapt for your own setup.

## License

MIT
