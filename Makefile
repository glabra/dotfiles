SHELL = /bin/sh
srcdir ?= ${PWD}
destdir ?= ${HOME}
src_types := main univ

.PHONY: usage build clean nvim-init

usage:
	@echo 'install:'
	@echo '  SRC_TYPE=($(src_types)) make build'
	@echo 'uninstall:'
	@echo '  SRC_TYPE=($(src_types)) make clean'

ifeq ("$(filter $(src_types), $(SRC_TYPE))","")
build clean: usage

else # if $(SRC_TYPE) is valid
destfiles = $(addprefix $(destdir)/., $(shell cd $(srcdir)/$(SRC_TYPE); find * -type f))
vundle_url := https://github.com/gmarik/Vundle.vim.git
vundle_destdir = $(destdir)/.nvim/bundle/Vundle.vim

build: $(destfiles)
ifeq "$(SRC_TYPE)" "main"
ifeq "$(shell test ! -d $(vundle_destdir); echo $$?)" "0"
	$(MAKE) nvim-init
endif
endif

clean:
	rm -f $(destfiles)
	@rmdir $(foreach d,$(dir $(destfiles)),$(d)) >/dev/null 2>&1 || true
ifeq "$(SRC_TYPE)" "main"
	rm -rf $(destdir)/.nvim # for .nvim/bundles
endif

$(destfiles): $(destdir)/.%: $(srcdir)/$(SRC_TYPE)/%
	@mkdir -p $(dir $@) 2>&1 || true
	cp -f $< $@

nvim-init:
	git clone '$(vundle_url)' '$(vundle_destdir)'

endif # end $(SRC_TYPE) is valid or not

