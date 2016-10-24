SHELL = /bin/sh
GIT := git
MKDIR := mkdir
WGET := wget
VIM := vim
destdir ?= ${HOME}
percent := %

cloning = \
	$(if \
		$(filter-out $(shell test -d '$($(1)_destdir)'; echo $$?),0), \
		$(GIT) clone --depth 1 '$($(1)_url)' '$($(1)_destdir)',)

config := $(destdir)/.vim
vimplug_dest := $(config)/autoload/plug.vim
vimplug_url := https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

install:
ifneq "$(shell test -f $(vimplug_dest); echo $$?)" "0"
	$(MKDIR) -p '$(dir $(vimplug_dest))'
	$(WGET) -O '$(vimplug_dest)' '$(vimplug_url)'
	$(VIM) +PlugInstall +qall
endif

uninstall:
	@$(RM) -r -- '$(config)'

