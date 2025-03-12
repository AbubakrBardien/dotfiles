## To be able to change directory when exiting Yazi. Call it with 'yy'
function yy() {
	# shellcheck disable=SC2155
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd" || exit
	fi
	rm -f -- "$tmp"
}
