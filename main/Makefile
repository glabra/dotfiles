SHELL = /bin/sh
GIT := git
NVIM := nvim
destdir ?= ${HOME}
percent := %

cloning = \
	$(if \
		$(filter-out $(shell test -d '$($(1)_destdir)'; echo $$?),0), \
		$(GIT) clone '$($(1)_url)' '$($(1)_destdir)',)

nvim_config := $(destdir)/.config/nvim
vundle_destdir := $(nvim_config)/bundle/Vundle.vim
vundle_url := https://github.com/gmarik/Vundle.vim.git

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
ifneq "$(shell test -d $(vundle_destdir); echo $$?)" "0"
	$(GIT) clone '$(vundle_url)' '$(vundle_destdir)'
	$(NVIM) +PluginInstall +qall
endif

uninstall:
	@$(RM) -- '$(nvim_config)'
ifeq "$(shell test -d $(rbenv_destdir); echo $$?)" "0"
	@printf '$(percent)s\n' "* Execute \`rm -rf -- '$(destdir)/.rbenv'\` to uninstall rbenv. *"
endif

