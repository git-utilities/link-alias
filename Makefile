#!/usr/bin/make -f


# Install/Uninstall make script for `git-utilities/aliases` linker script
# Copyright (C) 2021 S0AndS0
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, version 3 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.


#
#    Make variables to satisfy conventions
#
NAME = git-link-alias
VERSION = 0.0.1
PKG_NAME = $(NAME)-$(VERSION)


#
#    Make variables that readers &/or maintainers may wish to modify
#
INSTALL_DIRECTORY = $(HOME)/bin
SCRIPT_NAME = git-link-alias
MAN_PATH := $(firstword $(subst :, ,$(shell manpath)))
MAN_DIR_NAME := man1
GIT_BRANCH := main
GIT_REMOTE := origin


#
#    Make variables set upon run-time
#
## Obtain directory path that this Makefile lives in
##  Note ':=' is to avoid late binding that '=' entails
ROOT_DIRECTORY_PATH := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))


## Detect Operating System
ifeq '$(findstring :,$(PATH))' ';'
	__OS__ := Windows
else
	__OS__ := $(shell uname 2>/dev/null || echo 'Unknown')
	__OS__ := $(patsubst CYGWIN%,Cygwin,$(__OS__))
	__OS__ := $(patsubst MSYS%,MSYS,$(__OS__))
	__OS__ := $(patsubst MINGW%,MSYS,$(__OS__))
endif


#
#    Override variables via optional configuration file
#
CONFIG := $(ROOT_DIRECTORY_PATH)/.make-config
ifneq ("$(wildcard $(CONFIG))", "")
	include $(CONFIG)
endif


#
#    Make variables built from components
#
SCRIPT__SOURCE_PATH := $(ROOT_DIRECTORY_PATH)/$(SCRIPT_NAME)
SCRIPT__INSTALL_PATH := $(INSTALL_DIRECTORY)/$(SCRIPT_NAME)
MAN__SOURCE_DIR := $(ROOT_DIRECTORY_PATH)/$(MAN_DIR_NAME)
MAN__INSTALL_DIR := $(MAN_PATH)/$(MAN_DIR_NAME)


#
#    Make options/commands
#
.PHONY: clean install uninstall upgrade git-pull list link-script unlink-script man link-manual unlink-manual
.SILENT: config clean debug list link-script unlink-script man link-manual unlink-manual
.ONESHELL: install

clean: SHELL := /bin/bash
clean: ## Removes configuration file
	[[ -f "$(CONFIG)" ]] && {
		rm -v "$(CONFIG)"
	}

config: SHELL := /bin/bash
config: ## Writes configuration file
	tee "$(CONFIG)" 1>/dev/null <<EOF
	INSTALL_DIRECTORY = $(INSTALL_DIRECTORY)
	SCRIPT_NAME = $(SCRIPT_NAME)
	__OS__ = $(__OS__)
	MAN_PATH = $(MAN_PATH)
	MAN_DIR_NAME = $(MAN_DIR_NAME)
	GIT_BRANCH = $(GIT_BRANCH)
	GIT_REMOTE = $(GIT_REMOTE)
	EOF

install: ## Runs targets -> link-script 
install: | link-script

uninstall: ## Runs targets -> unlink-script 
uninstall: | unlink-script

upgrade: ## Runs targets -> uninstall git-pull install
upgrade: | uninstall git-pull install

git-pull: SHELL := /bin/bash
git-pull: ## Pulls updates from default upstream Git remote
	pushd "$(ROOT_DIRECTORY_PATH)"
	git pull $(GIT_REMOTE) $(GIT_BRANCH)
	[[ -f "$(ROOT_DIRECTORY_PATH)/.gitmodules" ]] && {
		git submodule update --init --merge --recursive
	}
	popd

link-script: SHELL := /bin/bash
link-script: ## Symbolically links git-link-alias
	if [[ -L "$(SCRIPT__INSTALL_PATH)" ]]; then
		printf '  Link found for %s\n' "$(SCRIPT_NAME)"
	else
		ln -sv "$(ROOT_DIRECTORY_PATH)/$(SCRIPT_NAME)" "$(SCRIPT__INSTALL_PATH)"
	fi

unlink-script: SHELL := /bin/bash
unlink-script: ## Removes symbolic links for git-link-alias
	if [[ -L "$(SCRIPT__INSTALL_PATH)" ]]; then
		rm -v "$(SCRIPT__INSTALL_PATH)"
	else
		printf '  No link found for %s\n' "$(SCRIPT_NAME)"
	fi

man: SHELL := /bin/bash
man: ## Builds manual pages via `help2man` command
	if [[ -d "$(MAN__SOURCE_DIR)" ]]; then
		help2man "$(SCRIPT__SOURCE_PATH)" --output="$(MAN__SOURCE_DIR)/$(NAME).1" --no-info
	fi

link-manual: SHELL := /bin/bash
link-manual: ## Symbolically links project manual page(s)
	if ! [[ -d "$(MAN__SOURCE_DIR)" ]]; then
		printf >&2 'No manual entries found at -> %s\n' "$(MAN__SOURCE_DIR)"
		exit 0
	fi
	while read -r _page; do
		if [[ -L "$(MAN__INSTALL_DIR)/$${_page}" ]]; then
			printf >&2 'Link already exists -> %s\n' "$(MAN__INSTALL_DIR)/$${_page}"
		else
			ln -sv "$(MAN__SOURCE_DIR)/$${_page}" "$(MAN__INSTALL_DIR)/$${_page}"
		fi
	done < <(ls "$(MAN__SOURCE_DIR)")

unlink-manual: SHELL := /bin/bash
unlink-manual: ## Removes symbolic links to project manual page(s)
	if ! [[ -d "$(MAN__SOURCE_DIR)" ]]; then
		printf >&2 'No manual entries found at -> %s\n' "$(MAN__SOURCE_DIR)"
		exit 0
	fi
	while read -r _page; do
		if [[ -L "$(MAN__INSTALL_DIR)/$${_page}" ]]; then
			rm -v "$(MAN__INSTALL_DIR)/$${_page}"
		else
			printf >&2 'No manual page found at -> %s\n' "$(MAN__INSTALL_DIR)/$${_page}"
		fi
	done < <(ls "$(MAN__SOURCE_DIR)")

list: SHELL := /bin/bash
list: ## Lists available make commands
	gawk 'BEGIN {
		delete matched_lines
	}
	{
		if ($$0 ~ "^[a-z0-9A-Z-]{1,32}: [#]{1,2}[[:print:]]*$$") {
			matched_lines[length(matched_lines)] = $$0
		}
	}
	END {
		print "## Make Commands for $(NAME) ##\n"
		for (k in matched_lines) {
			split(matched_lines[k], line_components, ":")
			gsub(" ## ", "    ", line_components[2])
			print line_components[1]
			print line_components[2]
			if ((k + 1) != length(matched_lines)) {
				print
			}
		}
	}' "$(ROOT_DIRECTORY_PATH)/Makefile"

