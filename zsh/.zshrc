# ~/.zshrc

# ------------------------------------------------------------------------------
# SECTION 1: EXPORTS & ENVIRONMENT VARIABLES
#
# Centralized place for all environment variables and PATH modifications.
# Using 'typeset -U path' removes duplicate entries automatically.
# ------------------------------------------------------------------------------

# Use nvim as the default editor
export EDITOR='nvim'
export MANPAGER='nvim +Man!'
export PAGER='less -R'
export GUI=1
export ICONLOOKUP=1

# Go
export GOPATH="$HOME/go"

# Volta (for Node/pnpm management)
export VOLTA_HOME="$HOME/.volta"
export VOLTA_FEATURE_PNPM=1

# Oh My Zsh installation path
export ZSH="$HOME/.oh-my-zsh"

# Centralized PATH setup
# typeset -U ensures no duplicate paths are added.
typeset -U path
path=(
    "$VOLTA_HOME/bin"
    "$HOME/.moon/bin"
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$GOPATH/bin"
    "/opt/homebrew/opt/openjdk@11/bin"
    "$HOME/.config/composer/vendor/bin"
    "$HOME/fvm/default/bin"
    "$HOME/.pub-cache/bin"
    "$PNPM_HOME"
    "/Users/v01d/.spicetify" # As per your config
    $path
)

# ------------------------------------------------------------------------------
# SECTION 2: ALIASES & SHELL SETTINGS
# ------------------------------------------------------------------------------

# Aliases
alias ni='nvim'
alias ls='ls -G' # Use -G for color on macOS/BSD, --color=auto on Linux
alias py='python3'
alias python='python3'

# Enable Vi mode
bindkey -v

# Edit current command line in $EDITOR with Ctrl+X+E (normal mode) or v (vicmd)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line
bindkey -M vicmd 'v' edit-command-line

# ------------------------------------------------------------------------------
# SECTION 3: ZINIT PLUGIN MANAGEMENT 🚀
#
# All plugin loading is handled by Zinit for maximum performance.
# ------------------------------------------------------------------------------

# Load Zinit
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing Zinit…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit.git "$HOME/.local/share/zinit/zinit.git"
fi
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

# ---- Load Annexes (Plugins for Zinit) ----
# This gives Zinit superpowers like installing binaries, compiling code, etc.
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# ---- Theme ----
zinit light romkatv/powerlevel10k

# ---- Core Utility Plugins ----
# Completions with smart caching
zinit ice atinit"zicompinit"
zinit light zsh-users/zsh-completions

# Syntax Highlighting & Autosuggestions
zinit ice lucid wait'0'
zinit light zsh-users/zsh-autosuggestions
zinit ice lucid wait'0' compile'(src|init).zsh'
zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice lucid wait'0'
zinit light zdharma-continuum/history-search-multi-word

# ---- Oh My Zsh Plugins via Zinit Snippets ----
zinit snippet OMZP::git
zinit snippet OMZP::gh
zinit snippet OMZP::golang
zinit snippet OMZP::poetry

# ---- Other Plugins ----
# Truly lazy-loaded NVM
zinit light lukechilds/zsh-nvm

# FZF integration
zinit light andrewferrier/fzf-z

# ---- Your Custom Git Tools ----
# This is the block from your original config that required the annexes.
# It installs several helpful git command-line utilities.
zi as'null' lucid sbin wait'1' for \
    Fakerr/git-recall \
    davidosomething/git-my \
    iwata/git-now \
    paulirish/git-open \
    paulirish/git-recent \
    atload'export _MENU_THEME=legacy' \
    arzzen/git-quick-stats \
    make'install' \
    tj/git-extras \
    make'GITURL_NO_CGITURL=1' \
    sbin'git-url;git-guclone' \
    zdharma-continuum/git-url

# ------------------------------------------------------------------------------
# SECTION 4: APPLICATION & TOOL INITIALIZATION
#
# Initializes tools like Conda, Direnv, etc. Should be at the end.
# ------------------------------------------------------------------------------

# Powerlevel10k Instant Prompt
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Direnv
eval "$(direnv hook zsh)"

# zoxide (a smarter cd command)
eval "$(zoxide init zsh)"

# Conda
# NOTE: Conda initialization is slow. It's placed near the end for this reason.
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# Google Cloud SDK
if [ -f '/Users/v01d/Downloads/google-cloud-sdk/path.zsh.inc' ]; then
    . '/Users/v01d/Downloads/google-cloud-sdk/path.zsh.inc'
fi
if [ -f '/Users/v01d/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then
    . '/Users/v01d/Downloads/google-cloud-sdk/completion.zsh.inc'
fi

# Bash completions
autoload -U +X bashcompinit && bashcompinit

# Other completions
[ -s "/Users/v01d/.jabba/jabba.sh" ] && source "/Users/v01d/.jabba/jabba.sh"
[[ -f /Users/v01d/.dart-cli-completion/zsh-config.zsh ]] && . /Users/v01d/.dart-cli-completion/zsh-config.zsh || true
eval "$(colima completion zsh)"
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# Source Oh My Zsh library files AFTER plugins and theme are loaded by Zinit
# This disables OMZ's own plugin/theme loading for speed.
ZSH_THEME=""
plugins=()
source $ZSH/oh-my-zsh.sh

# [Final] If you have a ~/.zshrc.local file, you can place personal, private
# overrides there.
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi
