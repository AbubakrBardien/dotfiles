# Dotfiles

My Dotfiles configuration. This repo covers _package configurations_.
It is cloned as part of the first-boot steps in the NixOS repo's README. Start there if this is a fresh install.

System-level config files are stored in a separate repo: [AbubakrBardien/nixos-config](https://github.com/AbubakrBardien/nixos-config)

| Repo | Purpose | Lives at |
|------|---------|----------|
| NixOS repo | System configuration (`configuration.nix`) | `/etc/nixos` |
| Dotfiles repo | Config files in `$HOME` | `~/dotfiles` |

---

## Setup

Each top-level directory in this repo is a [GNU Stow](https://www.gnu.org/software/stow/) package that mirrors the layout of `$HOME`. The setup script symlinks every package into your home directory.

### Apply The Dotfiles

If `stow` isn't installed yet, open a shell that has it first:

```sh
nix-shell -p stow
```

Then run the setup script from the repo:

```sh
cd ~/dotfiles
./setup.sh
```

If any package fails, the script lists it at the end. The usual cause is an existing file at the target location, which Stow refuses to overwrite. Move or delete the file, then run the script again.

### Check The Result

```sh
ls -l ~/.config/git
```

You should see a real directory containing a `config` symlink pointing into `~/dotfiles`. If `~/.config/git` itself is a symlink, Stow didn't read `.stowrc`. Make sure you ran the script from the repo, and fix that before pushing any changes.

### Save The PAT

The linked `~/.config/git/config` sets your git identity and tells git to store credentials in `~/.config/git/credentials`. That file holds your GitHub PAT, so it is never version controlled.

The repo is public, so cloning didn't prompt for credentials. The first `git push` to a repo will prompt for your GitHub username and PAT, and then save them automatically.

### Next Steps

Go back to the NixOS repo's README to return to Hyprland.

---

## Adding A Package

Create a directory named after the program, then mirror the path from `$HOME` inside it. For example, `git/.config/git/config` links to `~/.config/git/config`. The setup script picks up new directories automatically.
