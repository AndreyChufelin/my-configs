# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mole/.zshrc'

autoload -Uz compinit
compinit

export TERM='xterm-256color'
export EDITOR='nvim'
export VISUAL='nvim'

# colors
autoload -U colors && colors
NEWLINE=$'\n'
PS1="%F{magenta}%n%f@%F{cyan}%m%f %{$fg[yellow]%}%~%{$reset_color%}${NEWLINE}%# "

echo '\e[5 q'



alias config='/usr/bin/git --git-dir=$HOME/my-configs/ --work-tree=$HOME' 





bindkey -e

# Load widgets that are not loaded by default.
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search

autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search

function () {
	emulate -L zsh -o no_aliases

	# Make sure that the terminal is in application mode when zle is active,
	# since only then values from $terminfo are valid.
	if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
		autoload -U add-zle-hook-widget

		function .zshrc::term-application-mode() {
			echoti smkx
		}
		add-zle-hook-widget zle-line-init .zshrc::term-application-mode

		function .zshrc::term-normal-mode() {
			echoti rmkx
		}
		add-zle-hook-widget zle-line-finish .zshrc::term-normal-mode
	fi

	# `seq` is a fallback for the case when terminfo is not available.
	local kcap seq widget
	for	kcap   seq        widget (                       # key name
		khome  '^[[H'     beginning-of-line              # Home
		khome  '^[OH'     beginning-of-line              # Home (in app mode)
		kend   '^[[F'     end-of-line                    # End
		kend   '^[OF'     end-of-line                    # End (in app mode)
		kdch1  '^[[3~'    delete-char                    # Delete
		kpp    '^[[5~'    up-line-or-history             # PageUp
		knp    '^[[6~'    down-line-or-history           # PageDown
		kcuu1  '^[[A'     up-line-or-beginning-search    # UpArrow - fuzzy find history backward
		kcuu1  '^[OA'     up-line-or-beginning-search    # UpArrow - fuzzy find history backward (in app mode)
		kcud1  '^[[B'     down-line-or-beginning-search  # DownArrow - fuzzy find history forward
		kcud1  '^[OB'     down-line-or-beginning-search  # DownArrow - fuzzy find history forward (in app mode)
		kcbt   '^[[Z'     reverse-menu-complete          # Shift + Tab
		x      '^[[2;5~'  copy-region-as-kill            # Ctrl + Insert
		kDC5   '^[[3;5~'  kill-word                      # Ctrl + Delete
		kRIT5  '^[[1;5C'  forward-word                   # Ctrl + RightArrow
		kLFT5  '^[[1;5D'  backward-word                  # Ctrl + LeftArrow
	); do
		bindkey -M emacs ${terminfo[$kcap]:-$seq} $widget
		bindkey -M viins ${terminfo[$kcap]:-$seq} $widget
		bindkey -M vicmd ${terminfo[$kcap]:-$seq} $widget
	done
}










# bindkey -v
# source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
#source $HOME/.zsh-vi-mode/zsh-vi-mode.plugin.zsh
source /usr/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/.local/share/zsh/plugins/zsh-shift-select/zsh-shift-select.plugin.zsh
bindkey -M menuselect '\r' .accept-line

if [[ "$PATH" != *"$HOME/.local/bin"* ]] || [[ "$PATH" != *"$HOME/bin"* ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

# Append additional paths to PATH
export PATH="$PATH:~/bin"
export PATH="$PATH:/usr/local/bin/nvim/bin"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/go/bin"
