$env.config = { show_banner: false } 

if (which "tmux" | is-not-empty) and ($env.TMUX? == null) {
	tmux
}
