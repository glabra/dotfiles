SHELL = /bin/sh
GIT := git
CURL := curl
NVIM := nvim
destdir ?= ${HOME}
percent := %

cloning = \
	$(if \
		$(filter-out $(shell test -d '$($(1)_destdir)'; echo $$?),0), \
		$(GIT) clone --depth 1 '$($(1)_url)' '$($(1)_destdir)',)

nvim_config := $(destdir)/.config/nvim
vimplug_dest := $(nvim_config)/autoload/plug.vim
vimplug_url := https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

install:
ifneq "$(shell test -f $(vimplug_dest); echo $$?)" "0"
	$(CURL) -fLo '$(vimplug_dest)' --create-dirs '$(vimplug_url)'
	$(NVIM) +PlugInstall +qall
	$(NVIM) +UpdateRemotePlugins +qall
endif

uninstall:
	@$(RM) -r -- '$(nvim_config)'

