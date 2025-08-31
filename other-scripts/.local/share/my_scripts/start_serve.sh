#!/usr/bin/env bash

# shellcheck disable=SC2086

startpage_dir=$HOME/Documents/External_Repos/browser-startpage/_site

# Check if the directory exists
if [ ! -d $XDG_STATE_HOME/serve ]; then
	mkdir $XDG_STATE_HOME/serve
fi

errorFile=$XDG_STATE_HOME/serve/serve.err

# Serve the startpage in the background
serve $startpage_dir 1>/dev/null 2>$errorFile &
