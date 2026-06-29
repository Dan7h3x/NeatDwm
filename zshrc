# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster" # set by `omz`

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-interactive-cd zsh-navigation-tools)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias l="eza -T -L 2 -G --icons --color=always"
alias ls="l -a"
alias lt="l --level=3"
alias ipython="ipython --colors=linux"
alias get="git clone --depth 1"
alias lzvim="NVIM_APPNAME=nvim-lazy nvim"
alias tvim="NVIM_APPNAME=nvim-test nvim"
alias fvim="NVIM_APPNAME=nvim-fzf nvim"
alias surf='xembed -e surf'


cdf() {
  selected_dir=$(fd --type d --hidden --exclude \
    .git --exclude node_modules --exclude .cache --follow |
    fzf -i --layout=reverse \
      --preview='exa -T -L 2 -G --icons --git-ignore --color=always {}' \
      --preview-window=up\
      --prompt='Change Dir: ') && [[ -n "$selected_dir" ]] && cd "$selected_dir"
}



sf() {
  while true; do
    selected_file=$(fd --type f --extension "$1" --hidden --exclude \
      .git --exclude node_modules --exclude .cache --follow --full-path "$2" |
      fzf -i --layout=reverse \
      --preview="prevme {}" \
      --preview-window=right \
      --prompt='Find Files (Ctrl+C to exit | Ctrl+R clear tabbed): ' \
      --bind "ctrl-r:execute(rm -rf /tmp/tabpdf.txt)")
    if [[ -f "/tmp/tabpdf.txt" || -s "/tmp/tabpdf.txt" ]] && [[ -n "$selected_file" ]];then
      # notify-send "The tabbed session" "$(cat /tmp/tabpdf.txt)"
      ( nohup zathura --reparent="$(cat /tmp/tabpdf.txt)" "$selected_file" >/dev/null 2>&1 & ) &
      clear
      continue
    else
      if [[ -n "$selected_file" ]]; then
        # Launch file completely detached
        (
          nohup xdg-open "$selected_file" > /dev/null 2>&1 &
          ) &

          # Clear screen and restart
          clear
          echo "File opened. Select another file..."
          continue
        else
          # No file selected, exit
          break
      fi
      break
    fi

    done
}

txsf(){
  cd "/usr/local/texlive/2025/texmf-dist/"
  sf pdf
  cd
}

tabpdf(){
  TABBED_XID=$(tabbed -cd zathura -e)
  selected_file=$(fd --type f --extension pdf --hidden --exclude \
      .git --exclude node_modules --exclude .cache --follow --full-path "$1" |
      fzf -m -i --layout=reverse \
        --preview="prevme {}" \
        --preview-window=right \
        --prompt='Find Files (Ctrl+C to exit): ')

  zathura --reparent="$TABBED_XID" "$selected_file"
}

y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# nsx(){
#   OPENER='printf "%s\0"' SIZE=768 nsxiv-thumb -e "$TABBED_XID" | xargs -r0 realpath -sm -- | while IFS= read -r i; do
#         lf -remote "send $id select '$i'" && lf -remote "send $id toggle"
#     done
#     lf -remote "send $id select '$f'"
# }

if [[ "$XDG_SESSION_TYPE" == "x11" ]]; then
  export TERMINAL="st"
else
  export TERMINAL="foot"
fi
export QUTE_BIB_FILEPATH="/home/kratos/Desktop/MyBibs/qute.bib"


