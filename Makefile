# SPDX-License-Identifier: GPL-3.0-or-later

#    -----------------------------------------------------
#    Copyright © 2024, 2025, 2026  Pellegrino Prevete
#
#    All rights reserved
#    -----------------------------------------------------
#
#    This program is free software: you can redistribute
#    it and/or modify it under the terms of the
#    GNU Affero General Public License as published by
#    the Free Software Foundation, either version 3 of
#    the License, or (at your option) any later version.
#
#    This program is distributed in the hope that it
#    will be useful, but WITHOUT ANY WARRANTY;
#    without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#    See the GNU Affero General Public License for
#    more details.
#
#    You should have received a copy of the
#    GNU Affero General Public License
#    along with this program.
#    If not, see <https://www.gnu.org/licenses/>.

_NPM ?= false
SHELL ?= bash
PREFIX ?= /usr/local
SOLIDITY_COMPILER_BACKEND ?= solc
_PROJECT_NPM=evmfs
_PROJECT=$(_PROJECT_NPM).js
DOC_DIR=$(DESTDIR)$(PREFIX)/share/doc/$(_PROJECT_NPM)
BIN_DIR=$(DESTDIR)$(PREFIX)/bin
LIB_DIR=$(DESTDIR)$(PREFIX)/lib/$(_PROJECT_NPM)
MAN_DIR?=$(DESTDIR)$(PREFIX)/share/man
USR_DIR=$(DESTDIR)$(PREFIX)
NODE_DIR=$(DESTDIR)$(PREFIX)/lib/node_modules/$(_PROJECT_NPM)
BUILD_DIR=build

DOC_FILES=\
  $(wildcard \
      *.rst) \
  $(wildcard \
      docs/*.md)

_NODE_FILES:=\
  ccget \
  check \
  get \
  index \
  lengthlock \
  libevmfs \
  lock \
  publish \
  publish.bulk \
  verify

_NPM_FILES:=\
  AUTHORS.rst \
  COPYING \
  README.md \
  dist \
  lib \
  eslint.config.mjs \
  fs-worker.webpack.config.cjs \
  package.json \
  webpack.config.cjs

_MAKE_LINK=\
  ln \
    -sv
_MAKE_EXE=\
  chmod \
    755
_INSTALL_FILE=\
  install \
    -vDm644
_INSTALL_DIR=\
  install \
    -vdm755
_INSTALL_EXE=\
  install \
    -vDm755

_INSTALL_CONTRACTS_DEPLOYMENT_FUN:=\
  install-contracts-deployments-$(SOLIDITY_COMPILER_BACKEND)
_BUILD_TARGETS:=\
  build-npm
  # contracts
_BUILD_TARGETS_ALL:=\
  all \
  $(_BUILD_TARGETS)
_CHECK_TARGETS:=\
  eslint
_CHECK_TARGETS_ALL:=\
  check \
  $(_CHECK_TARGETS)
_CLEAN_TARGETS_ALL:=\
  clean
# _INSTALL_CONTRACTS_TARGETS:=\
#   $(_INSTALL_CONTRACTS_DEPLOYMENT_FUN)  \
#   install-contracts-deployments-config \
#   install-contracts-sources
# _INSTALL_CONTRACTS_TARGETS_ALL:=\
#   install-contracts \
#   install-contracts-deployments-hardhat \
#   install-contracts-deployments-solc \
#   install-contracts-deployments-config \
#   install-contracts-sources
_INSTALL_DOC_TARGETS:=\
  install-doc \
  install-man
_INSTALL_SCRIPTS_TARGETS:=\
  install-node-scripts
_INSTALL_SCRIPTS_TARGETS_ALL:=\
  $(_INSTALL_SCRIPTS_TARGETS) \
  install-scripts
_INSTALL_TARGETS:=\
  $(_INSTALL_DOC_TARGETS) \
  install-scripts
  # $(_INSTALL_CONTRACTS_TARGETS)
_INSTALL_TARGETS_ALL:=\
  install \
  $(_INSTALL_DOC_TARGETS) \
  $(_INSTALL_SCRIPTS_TARGETS_ALL)
  # $(_INSTALL_CONTRACTS_TARGETS_ALL)
_UNINSTALL_SCRIPTS_TARGETS:=\
  uninstall-node-scripts
_UNINSTALL_SCRIPTS_TARGETS_ALL:=\
  $(_UNINSTALL_SCRIPTS_TARGETS) \
  uninstall-scripts
_UNINSTALL_TARGETS:=\
  uninstall-scripts
_UNINSTALL_TARGETS_ALL:=\
  $(_UNINSTALL_SCRIPTS_TARGETS_ALL) \
  uninstall
_PHONY_TARGETS:=\
  $(_BUILD_TARGETS_ALL) \
  $(_CHECK_TARGETS_ALL) \
  $(_BUILD_TARGETS_ALL) \
  $(_CLEAN_TARGETS_ALL) \
  $(_INSTALL_TARGETS_ALL) \
  $(_UNINSTALL_TARGETS_ALL)

all: $(_BUILD_TARGETS)

install: $(_INSTALL_TARGETS)

check: $(_CHECK_TARGETS)

install-contracts: $(_INSTALL_CONTRACTS_TARGETS)

install-scripts: $(_INSTALL_SCRIPTS_TARGETS)

uninstall: $(_UNINSTALL_TARGETS)

uninstall-scripts: $(_UNINSTALL_SCRIPTS_TARGETS)

build-man:

	mkdir \
	  -p \
	  "$(BUILD_DIR)/man"
	for _program in $(_NODE_FILES); do \
	  if [[ "$${_program}" != "libevmfs" ]]; then \
	    rst2man \
	      "man/$(_PROJECT).$${_program}.1.rst" \
	      "$(BUILD_DIR)/man/$(_PROJECT).$${_program}.1"; \
	  fi \
	done; \

build-npm:

	make \
	  build-man
	cp \
	  -r \
	  $(_NPM_FILES) \
	  "lib$(_PROJECT_NPM)" \
	  "$(_PROJECT_NPM)" \
	  "build"; \
	cd \
	  "build"; \
	_version="$$( \
	  npm \
	    view \
	      "$${PWD}" \
	      "version")"; \
	npm \
	  install; \
	npm \
	  run \
	    "build"; \
	npm \
	  pack; \
	mv \
	  "$(_PROJECT_NPM)-$${_version}.tgz" \
	  ".."

clean:

	rm \
	  -rf \
	  "$(BUILD_DIR)"

contracts:

	git \
	  submodule \
	    update \
	      --init \
	      "contracts" || \
	true
	cd \
	  "contracts"; \
	make \
	  contracts

eslint:

	npm \
	  run \
	    lint


install-contracts-sources:

	git \
	  submodule \
	    update \
	      --init \
	      "contracts" || \
	true
	cd \
	  "contracts"; \
	make \
	  install-contracts-sources

install-contracts-deployments-config:

	git \
	  submodule \
	    update \
	      --init \
	      "contracts" || \
	true
	cd \
	  "contracts"; \
	make \
	  install-contracts-deployments-config

install-contracts-deployments-solc:

	git \
	  submodule \
	    update \
	      --init \
	      "contracts" || \
	true
	cd \
	  "contracts"; \
	make \
	  install-contracts-deployments-solc

install-contracts-deployments-hardhat:

	git \
	  submodule \
	    update \
	      --init \
	      "contracts" || \
	true
	cd \
	  "contracts"; \
	make \
	  install-contracts-deployments-hardhat

install-doc:

	$(_INSTALL_FILE) \
	  $(DOC_FILES) \
	  -t $(DOC_DIR)
	mv \
	  "$(DOC_DIR)/README.md" \
	  "$(DOC_DIR)/docs.README.md"
	$(_INSTALL_FILE) \
	  "README.md" \
	  "$(DOC_DIR)/README.md"
	$(_INSTALL_DIR) \
	  "$(DOC_DIR)/media"
	$(_INSTALL_FILE) \
	  "docs/media/evmfs.png" \
	  "$(DOC_DIR)/media/evmfs.png"

install-man:

	$(_INSTALL_DIR) \
	  "$(MAN_DIR)/man1"
	for _file in $(_BASH_FILES); do \
	  rst2man \
	    "man/$${_file}.1.rst" \
	    "$(MAN_DIR)/man1/$${_file}.1"; \
	done

install-node-scripts:

	if [[ "$(_NPM)" == "false" ]]; then \
	  $(_INSTALL_DIR) \
	    "$(LIB_DIR)/nodejs"; \
	  cp \
	    -r \
	    $$(printf \
	         "$${PWD}/%s " \
	         $$(cat \
	              "$${PWD}/package.json" | \
	              jq \
	                --raw-output \
	                '.files[]')) \
	    "$(LIB_DIR)/nodejs"; \
	  $(_MAKE_EXE) \
	    "$(LIB_DIR)/nodejs/$(_PROJECT_NPM)"; \
	  for _program in \
	    $(_PROGRAMS); do \
	    if [[ ! -s "$(BIN_DIR)/$${_program}" && \
	          ! -e "$(BIN_DIR)/$${_program}" ]]; then \
	      $(_MAKE_LINK) \
	        "$(PREFIX)/lib/$(_PROJECT_NPM)/nodejs/$${_program}" \
	        "$(BIN_DIR)/$${_program}"; \
	    fi; \
	  done; \
	  rm \
	    "$(LIB_DIR)/node_modules" || \
	    true; \
	  if [[ ! -s "$(LIB_DIR)/node_modules" ]]; then \
	    $(_MAKE_LINK) \
	      "$(PREFIX)/lib/node_modules" \
	      "$(LIB_DIR)/nodejs/node_modules"; \
	  fi; \
	  rm \
	    -rf \
	    "$(DESTDIR)$(PREFIX)/lib/node_modules/$(_PROJECT)" \
	    "$(DESTDIR)$(PREFIX)/lib/node_modules/$(_PROJECT_NPM)"; \
	  if [[ ! -s "$(DESTDIR)$(PREFIX)/lib/node_modules/$(_PROJECT)" ]]; then \
	    $(_MAKE_LINK) \
	      "$(PREFIX)/lib/$(_PROJECT_NPM)/nodejs" \
	      "$(DESTDIR)$(PREFIX)/lib/node_modules/$(_PROJECT)"; \
	  fi; \
	  if [[ ! -s "$(DESTDIR)$(PREFIX)/lib/node_modules/$(_PROJECT_NPM)" ]]; then \
	    $(_MAKE_LINK) \
	      "$(PREFIX)/lib/$(_PROJECT_NPM)/nodejs" \
	      "$(DESTDIR)$(PREFIX)/lib/node_modules/$(_PROJECT_NPM)" || \
	      true; \
	  fi; \
	  if [[ ! -s "$(DESTDIR)$(PREFIX)/lib/$(_PROJECT)" ]]; then \
	    $(_MAKE_LINK) \
	      "$(PREFIX)/lib/$(_PROJECT_NPM)/nodejs" \
	      "$(DESTDIR)$(PREFIX)/lib/$(_PROJECT)" || \
	      true; \
	  fi; \
	  if [[ ! -s "$(DESTDIR)$(PREFIX)/lib/$(_PROJECT_NPM)" ]]; then \
	    $(_MAKE_LINK) \
	      "$(PREFIX)/lib/$(_PROJECT_NPM)/nodejs" \
	      "$(DESTDIR)$(PREFIX)/lib/$(_PROJECT_NPM)" || \
	      true; \
	  fi; \
	  for _file in $(_NODE_FILES); do \
	    $(_MAKE_LINK) \
	      "$(PREFIX)/lib/$(_PROJECT_NPM)/nodejs/lib/$${_file}" \
	      "$(LIB_DIR)/$${_file}"; \
	  done; \
	elif [[ "$(_NPM)" == "true" ]]; then \
	  make \
	    install-npm; \
	  $(_MAKE_LINK) \
	    "$(PREFIX)/lib/node_modules/$(_PROJECT_NPM)" \
	    "$(LIB_DIR)/nodejs" || \
	  true; \
	  for _file in $(_NODE_FILES); do \
	    $(_MAKE_LINK) \
	      "$(PREFIX)/lib/node_modules/$(_PROJECT_NPM)/lib/$${_file}" \
	      "$(LIB_DIR)/$${_file}"; \
	  done; \
	fi;

install-npm:

	if [[ ! -e "$${PWD}/$(_PROJECT_NPM)-$${_version}.tgz" ]] ; \
	  make \
	    build-npm; \
	fi; \
	_npm_opts=( \
	  -g \
	  --prefix \
	    "$(USR_DIR)" \
	); \
	_version="$$( \
	  npm \
	    view \
	      "$${PWD}" \
	      "version")"; \
	npm \
	  install \
	    "$${_npm_opts[@]}" \
	    "$${PWD}/$(_PROJECT_NPM)-$${_version}.tgz"; \
	$(_INSTALL_DIR) \
	  "$$(dirname \
	      "$(LIB_DIR)")"; \
	ln \
	  -s \
	  "$(NODE_DIR)/$(_PROJECT_NPM)" \
	  "$(LIB_DIR)" || \
	true; \
	ln \
	  -s \
	  "$(NODE_DIR)/fs-utils" \
	  "$(LIB_DIR)/fs-utils" || \
	true; \
	ln \
	  -s \
	  "$(NODE_DIR)/fs-worker" \
	  "$(LIB_DIR)/fs-worker" || \
	true; \
	ln \
	  -s \
	  "$(NODE_DIR)/utils" \
	  "$(LIB_DIR)/utils" || \
	true


publish-npm:

	mkdir \
	  -p \
	  "build"; \
	cd \
	  "$(BUILD_DIR)"; \
	npm \
	  publish

uninstall-node-scripts:

	declare \
	  -a \
	  _files; \
	for _file in $(_NODE_FILES); do \
	  _files+=(
	    "$(LIB_DIR)/$${_file}"
	  ); \
	done; \
	_files+=(
	  "$(LIB_DIR)/nodejs"
	  "$(DESTDIR)/$(PREFIX)/lib/$(_PROJECT)"
	)
	rm \
	  -vrf \
	  "${_files[@]}";

.PHONY: $(_PHONY_TARGETS)
