# dotfiles

Category: Productivity

## Install Dependencies
- POSIX compliant shell

### type: `main` only
- [git](https://git-scm.com/)
- [wget](https://busybox.net/) or [curl](https://curl.haxx.se/)
- [openssl](https://www.openssl.org/) for https access
- [vim](http://www.vim.org/)

## Installation
I recommend to fork this repository and remove unusable files/dirs before you try this dotfiles.
Use at your own risk.

```shell
git clone 'https://github.com/glabra/dotfiles.git' "${HOME}/.dotfiles"
cd "${HOME}/.dotfiles"
./bootstrap.sh install main
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

