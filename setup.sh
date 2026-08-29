#!/usr/bin/env bash

# sudo sbctl create-keys
# sudo sbctl enroll-keys -m
# sudo sbctl sign -s /boot/EFI/NixOS-boot/grubx64.efi
# sudo sbctl sign -s /boot/EFI/Grub/grubx64.efi

###################################
## Creating XDG User Directories ##
###################################

echo "==> Creating User Directories..."
mkdir -p "$HOME"/{Desktop,Downloads,Documents,Pictures,Videos,Documents/External_Repos}

############################
## Set Minimum Brightness ##
############################
echo "==> Setting Minimum Brightness..."
brillo -c 5 || echo "Warning: brillo failed. Ensure hardware.brillo.enable is set in NixOS config."

####################
## Setup Dotfiles ##
####################

cd "$HOME/dotfiles" || exit 1

# Ask for dry-run
read -r -p "Dry-run symlinks? (y/[n]) " input
input="${input:-n}" # Sets default to 'n' if empty

run_stow() {
	local dry_run_flag="$1"
	local failed_packages=()

	for dir in */; do
		pkg="${dir%/}"
		if [[ "$pkg" == "assets" ]]; then
			continue
		fi

		# Run stow and capture errors
		if [[ "$dry_run_flag" == "-n" ]]; then
			if ! stow "$dry_run_flag" -v -t "$HOME" "$pkg"; then
				echo -e "\n[!] ERROR: Failed to stow package '$pkg'."
				failed_packages+=("$pkg")
			fi
		else
			if ! stow -t "$HOME" "$pkg"; then
				echo -e "\n[!] ERROR: Failed to stow package '$pkg'."
				failed_packages+=("$pkg")
			fi
		fi
	done

	if [ ${#failed_packages[@]} -gt 0 ]; then
		echo -e "\n=========================================="
		echo "The following packages failed to symlink:"
		for failed in "${failed_packages[@]}"; do
			echo "  - $failed"
		done
		echo "=========================================="
		return 1
	fi
	return 0
}

if [[ "$input" =~ ^[Yy]$ ]]; then
	echo "==> Running Dry-Run..."
	if ! run_stow "-n"; then
		echo ""
		read -r -p "Conflicts detected during dry-run. Proceed anyway? (y/[n]) " force_apply
		force_apply="${force_apply:-n}"
		if [[ ! "$force_apply" =~ ^[Yy]$ ]]; then
			echo "Aborted."
			exit 1
		fi
	fi

	echo ""
	read -r -p "Apply real symlinks now? (y/[n]) " apply
	apply="${apply:-n}"

	if [[ "$apply" =~ ^[Yy]$ ]]; then
		run_stow ""
	else
		echo "Aborted without making changes."
	fi
else
	echo "==> Applying real symlinks..."
	run_stow ""
fi

################################################
## Import My other Repos that I use Regularly ##
################################################

echo "==> Importing Password Manager..."
# Download my Python Password Manager Script
download_url="https://raw.githubusercontent.com/AbubakrBardien/password-manager/main/password_manager.py"

mkdir -p "$HOME/.local/share/my_scripts/password_manager"
curl -L -o "$HOME/.local/share/my_scripts/password_manager/password_manager.py" "$download_url"

# Clone my Neovim config
if [ ! -d "$HOME/.config/nvim" ]; then
	echo "==> Importing Neovim Config..."
	git clone "https://github.com/AbubakrBardien/nvim.git" "$HOME/.config/nvim"
else
	echo "Neovim config already exists. Skipping..."
fi

# Cloned the forked 'browser-startpage' repo
if [ ! -d "$HOME/Documents/External_Repos/browser-startpage" ]; then
	echo "==> Importing Browser Startpage..."
	git clone "https://github.com/AbubakrBardien/browser-startpage.git" "$HOME/Documents/External_Repos/browser-startpage"
else
	echo "Startpage already exists. Skipping..."
fi

######################################
## Enable Custom Systemd Unit Files ##
######################################

echo "==> Enabling Systemd Unit Files..."
systemctl --user enable --now battery_monitor.timer system_update_reminder.timer
