# dotfiles

Category: Productivity


## Install Dependencies
- POSIX compliant shell

### type: `nvim`
- [nvim](https://neovim.io/)


## Dependencies
### type: `core`
- [wget](https://busybox.net/) or [curl](https://curl.haxx.se/)
- [openssl](https://www.openssl.org/) for https access

### type: `wsl`
- [Ubuntu](http://www.ubuntu.com/)
- [bash](https://www.gnu.org/software/bash/) or [zsh](http://www.zsh.org/)
- [Python3](https://www.python.org/) (keeagent-bridge)

### type: `nvim`
- [nvim](https://neovim.io/)

### type: `desktop`
- [st](https://github.com/glabra/local-pkgbuilds)
- [dwm](https://github.com/glabra/local-pkgbuilds)
- [fcitx](http://fcitx-im.org/)
- [xset](http://xorg.freedesktop.org/)
- [setxkbmap](http://xorg.freedesktop.org/)
- [connman](https://01.org/connman)
- [ponymix](https://github.com/falconindy/ponymix)
- [xsetroot](http://xorg.freedesktop.org/) (dwm-statusline)
- [feh](https://feh.finalrewind.org/) (wallpaper.sh)
- [imagemagick](http://www.imagemagick.org/) (wallpaper.sh)
- [bubblewrap](https://github.com/projectatomic/bubblewrap) (application sandboxing)
- [xrandr](http://www.x.org/wiki/Projects/XRandR/) (switch-monitor)
- [xsel](http://www.vergenet.net/~conrad/software/xsel/) (xdg-open-clipboard)
- [xdg-open](http://xorg.freedesktop.org/) (xdg-open-clipboard)
- [xsetwacom](http://linuxwacom.sourceforge.net/wiki/index.php/Xsetwacom) (wacom-init)
- [wmname](https://tools.suckless.org/x/wmname) (optional)
- [redshift](http://jonls.dk/redshift/) (optional)
- [xss-lock](https://bitbucket.org/raymonad/xss-lock) (optional)
- [slock](http://tools.suckless.org/slock) (optional)
- [compton](https://github.com/chjj/compton) (optional)
- [dispwin](http://www.argyllcms.com/doc/dispwin.html) (optional)
- [keepassxc](https://keepassxc.org/) (optional)


## Installation
I recommend to fork this repository and remove unusable files/dirs before you try this dotfiles.
Use at your own risk.

```shell
git clone 'https://github.com/glabra/dotfiles.git' "${HOME}/.dotfiles"
cd "${HOME}/.dotfiles"
./bootstrap.sh install [type...]
# `./bootstrap.sh install wsl core` or vice versa.
```

## Update
```shell
cd "${HOME}/.dotfiles"
git pull origin master
./bootstrap.sh
```

## License
These dotfiles are avaliable under the terms of the [Unlicense](http://unlicense.org/).
See the `LICENSE` file for more details.

