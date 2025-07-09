# tmux.zsh
function tx-init() {
	session="default"

	# check if session exists, discarding output
	tmux has-session -t $session 2>/dev/null # $? to check exit status

	if [ $? != 0 ]; then
		# Set up session
		tmux new -s default -c $HOME -n zsh 2>/dev/null
	fi

	# Attach to created session
	tmux attach-session -t $session
}

