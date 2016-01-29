SHELL = /bin/sh
FIND := find
srcdir ?= ${PWD}
export destdir ?= ${HOME}
src_types := $(shell $(FIND) * -maxdepth 0 -type d)
SRC_TYPE ?= $(shell if test -e '.src_type'; then cat .src_type; fi)

ifeq ("$(filter $(src_types), $(SRC_TYPE))","")
.PHONY: usage install uninstall sync
install uninstall sync: usage

else # if $(SRC_TYPE) is valid
.PHONY: usage install uninstall clean module-install module-uninstall sync

sourcedir := $(srcdir)/$(SRC_TYPE)
destfiles := $(addprefix $(destdir)/., $(shell cd $(sourcedir) && $(FIND) * -type f \! -name 'Makefile'))
submakefiles := $(addprefix $(sourcedir)/, $(shell cd $(sourcedir) && $(FIND) * -type f -name 'Makefile'))

install: .src_type $(destfiles) module-install

uninstall: module-uninstall
	@$(RM) -- $(foreach d,$(destfiles),'$(d)')
	@rmdir -p  $(foreach d,$(dir $(destfiles)),$(d)) >/dev/null 2>&1 || true

sync:
	@echo "WIP"

module-install: $(submakefiles)
	@(IFS=' '; for i in $^; do \
		cd `dirname $$i` && \
		$(MAKE) install; \
	done)

module-uninstall: $(submakefiles)
	@(IFS=' '; for i in $^; do \
		cd `dirname $$i` && \
		$(MAKE) uninstall; \
	done)

.src_type:
	echo '$(SRC_TYPE)' > '.src_type'

$(destfiles): $(destdir)/.%: $(sourcedir)/%
	@mkdir -p $(foreach d,$(dir $@),'$(d)') 2>&1 || true
	ln -s '$<' '$@'
endif

clean:
	$(RM) -- .src_type

usage:
	@echo 'usage:'
	@echo '  SRC_TYPE=($(src_types)) make ([install]|uninstall|sync)'

