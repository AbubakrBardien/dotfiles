#!/usr/bin/env bash

startpage_dir=$HOME/Documents/External_Repos/browser-startpage/_site

# Check if the directory exists
if [ ! -d "${XDG_STATE_HOME:-$HOME/.local/state}/serve" ]; then
	mkdir "${XDG_STATE_HOME:-$HOME/.local/state}/serve"
fi

errorFile=${XDG_STATE_HOME:-$HOME/.local/state}/serve/serve.err

# Serve the startpage in the background
serve "$startpage_dir" 1>/dev/null 2>"$errorFile" &
