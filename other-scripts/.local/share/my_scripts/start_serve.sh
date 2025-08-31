#!/usr/bin/env bash

# Set XDG_STATE_HOME if it's not already set
XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}

startpage_dir=$HOME/Documents/External_Repos/browser-startpage/_site

# Check if the directory exists
if [ ! -d "$XDG_STATE_HOME/serve" ]; then
	mkdir "$XDG_STATE_HOME/serve"
fi

errorFile=$XDG_STATE_HOME/serve/serve.err

# Serve the startpage in the background
serve "$startpage_dir" 1>/dev/null 2>"$errorFile" &
