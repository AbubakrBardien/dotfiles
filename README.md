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

The `.stowrc` in the repo root sets `--no-folding`, so Stow only links individual files, never whole directories. This matters for `~/.config/git` for example, which has to stay a real directory so the untracked credentials file doesn't end up inside this repo.

### Apply The Dotfiles

```sh
cd ~/dotfiles
./setup.sh
```

The script first asks whether to do a dry run. Press Enter (or `n`) to apply the symlinks straight away, or `y` to preview them first.

If any package fails, the script lists it at the end. The usual cause is an existing file at the target location, which Stow refuses to overwrite. Move or delete the file, then run the script again.

### Check The Result

```sh
ls -l ~/.config/git
```

You should see the contents of a real directory, including a `config` symlink pointing into `~/dotfiles`.

If you see a single line ending in `->` instead, `~/.config/git` itself is a symlink and Stow folded the directory. Fix that before pushing anything, since the credentials file would be written inside this repo. Check that `.stowrc` exists in `~/dotfiles`, run `stow -D git` from there, then run the script again.

### Save The PAT

The linked `~/.config/git/config` sets your git identity and tells git to store credentials in `~/.config/git/credentials`. That file holds your GitHub PAT, so it is never version controlled.

The repo is public, so cloning didn't prompt for credentials. The first `git push` to a repo will prompt for your GitHub username and PAT, and then save them automatically.

### Next Steps

Go back to the NixOS repo's [README](https://github.com/AbubakrBardien/nixos-config) to return to Hyprland.

---

## Adding Packages

Create a directory named after the program, then mirror the path from `$HOME` inside it. For example, `git/.config/git/config` links to `~/.config/git/config`. The setup script picks up new directories automatically.
