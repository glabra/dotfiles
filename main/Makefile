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

rbenv_destdir := $(destdir)/.rbenv
rbenv_url := https://github.com/sstephenson/rbenv.git
rbenv_plugindir := $(rbenv_destdir)/plugins
rubybuild_destdir := $(rbenv_plugindir)/ruby-build
rubybuild_url := https://github.com/sstephenson/ruby-build.git
rbenvgemset_destdir := $(rbenv_plugindir)/rbenv-gemset
rbenvgemset_url := git://github.com/jf/rbenv-gemset.git
rbenvupdate_destdir := $(rbenv_plugindir)/rbenv-update
rbenvupdate_url := https://github.com/rkh/rbenv-update.git

install:
	$(call cloning,rbenv)
	$(call cloning,rubybuild)
	$(call cloning,rbenvgemset)
	$(call cloning,rbenvupdate)
ifneq "$(shell test -f $(vimplug_dest); echo $$?)" "0"
	$(CURL) -fLo '$(vimplug_dest)' --create-dirs '$(vimplug_url)'
	$(NVIM) +PlugInstall +qall
	$(NVIM) +UpdateRemotePlugins +qall
endif

uninstall:
	@$(RM) -r -- '$(nvim_config)'
ifeq "$(shell test -d $(rbenv_destdir); echo $$?)" "0"
	@printf '$(percent)s\n' "* Execute \`rm -rf -- '$(destdir)/.rbenv'\` to uninstall rbenv. *"
endif

