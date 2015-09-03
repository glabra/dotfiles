SHELL = /bin/sh
FIND := find
GIT := git
srcdir ?= ${PWD}
destdir ?= ${HOME}
src_types = $(shell $(FIND) * -maxdepth 0 -type d)
SRC_TYPE ?= $(shell if test -e '.src_type'; then cat .src_type; fi)

.PHONY: usage install uninstall nvim-init

ifeq ("$(filter $(src_types), $(SRC_TYPE))","")
install uninstall: usage

else # if $(SRC_TYPE) is valid
destfiles = $(addprefix $(destdir)/., $(shell cd $(srcdir)/$(SRC_TYPE); $(FIND) * -type f))
vundle_destdir = $(destdir)/.nvim/bundle/Vundle.vim
vundle_url := https://github.com/gmarik/Vundle.vim.git

install: .src_type $(destfiles)
ifeq "$(SRC_TYPE)" "main"
ifneq "$(shell test -d $(vundle_destdir); echo $$?)" "0"
	$(MAKE) nvim-init
endif
endif

uninstall:
	rm -f $(destfiles)
	@rmdir $(foreach d,$(dir $(destfiles)),$(d)) >/dev/null 2>&1 || true
ifeq "$(SRC_TYPE)" "main"
	rm -rf $(destdir)/.nvim # for .nvim/bundles
endif

.src_type:
	echo "$(SRC_TYPE)" > .src_type

$(destfiles): $(destdir)/.%: $(srcdir)/$(SRC_TYPE)/%
	@mkdir -p $(dir $@) 2>&1 || true
	ln $< $@

nvim-init:
	$(GIT) clone '$(vundle_url)' '$(vundle_destdir)'

endif # end $(SRC_TYPE) is valid or not

usage:
	@echo 'install:'
	@echo '  SRC_TYPE=($(src_types)) make [install]'
	@echo 'uninstall:'
	@echo '  SRC_TYPE=($(src_types)) make uninstall'

