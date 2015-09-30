# dotfiles

Category: Productivity

## Dependencies
- [git](https://git-scm.com/)
- [GNU Make](https://www.gnu.org/software/make/)

### type: `main` only
- [neovim](https://github.com/neovim/neovim)

## Installation
I recommend to fork this repository and remove unusable files/dirs before you try this dotfiles.
Use at your own risk.

```shell
git clone 'https://github.com/glabra/dotfiles.git' "${HOME}/.dotfiles"
cd "${HOME}/.dotfiles"
SRC_TYPE='main' make install
```

## Update
```shell
cd "${HOME}/.dotfiles"
git pull origin master
make install
```

## Tips
`make usage` shows usage of the `/Makefile`.

## Bugs
- dotfiles that contains `'` in filename breaks `/Makefile` function.
- files that name is `Makefile` are always considered as `Makefile` regardless its content.

## License
These dotfiles are avaliable under the terms of the [MIT License](https://opensource.org/licenses/MIT).
See the `LICENSE` file for more details.

