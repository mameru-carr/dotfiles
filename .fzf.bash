# Setup fzf
# ---------
if [[ ! "$PATH" == */home/phoenix/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/phoenix/.fzf/bin"
fi

# Auto-completion
# ---------------
source "/home/phoenix/.fzf/shell/completion.bash"

# Key bindings
# ------------
source "/home/phoenix/.fzf/shell/key-bindings.bash"
