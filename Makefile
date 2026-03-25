# SPDX-License-Identifier: GPL-3.0-or-later

#    ----------------------------------------------------------------------
#    Copyright © 2024, 2025, 2026  Pellegrino Prevete
#
#    All rights reserved
#    ----------------------------------------------------------------------
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

SHELL=bash
PREFIX ?= /usr/local
SOLIDITY_COMPILER_BACKEND ?= solc
_PROJECT_NPM=evmfs
_PROJECT=$(_PROJECT_NPM).js
DOC_DIR=$(DESTDIR)$(PREFIX)/share/doc/$(_PROJECT)
BIN_DIR=$(DESTDIR)$(PREFIX)/bin
LIB_DIR=$(DESTDIR)$(PREFIX)/lib/$(_PROJECT)
MAN_DIR?=$(DESTDIR)$(PREFIX)/share/man
USR_DIR=$(DESTDIR)$(PREFIX)
BUILD_DIR=build

DOC_FILES=\
  $(wildcard *.rst) \
  $(wildcard docs/*.md)
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
  eslint.config.mjs \
  fs-worker.webpack.config.cjs \
  $(NODE_FILES) \
  package.json \
  webpack.config.cjs

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
	evm-make \
	  -v \
	  -C \
	    . \
	  -b \
	    "$(SOLIDITY_COMPILER_BACKEND)" \
	  -w \
	    "$(BUILD_DIR)"

install-contracts-sources:

	evm-make \
	  -v \
	  -C \
	    . \
	  -b \
	    "$(SOLIDITY_COMPILER_BACKEND)" \
	  -w \
	    "$(BUILD_DIR)" \
	  -o \
	    "$(LIB_DIR)" \
	  -l \
	    "n" \
	  install_sources

install-contracts-deployments-config:

	evm-make \
	  -v \
	  -C \
	    . \
	  -b \
	    "$(SOLIDITY_COMPILER_BACKEND)" \
	  -w \
	    "$(BUILD_DIR)" \
	  -o \
	    "$(LIB_DIR)" \
	  -l \
	    "n" \
	  install_deployments_config

install-contracts-deployments-solc:

	evm-make \
	  -v \
	  -C \
	    . \
	  -b \
	    "solc" \
	  -w \
	    "$(BUILD_DIR)" \
	  -o \
	    "$(LIB_DIR)" \
	  -l \
	    "n" \
	  install_deployments

install-contracts-deployments-hardhat:

	evm-make \
	  -v \
	  -C \
	    . \
	  -b \
	    "hardhat" \
	  -w \
	    "$(BUILD_DIR)" \
	  -o \
	    "$(LIB_DIR)" \
	  -l \
	    "n" \
	  install_deployments

build-man:

	mkdir \
	  -p \
	  "$(BUILD_DIR)/man"
	for _program in $(_NODE_FILES); do \
	  rst2man \
	    "man/$(_PROJECT_NPM).$${_program}.1.rst" \
	    "$(BUILD_DIR)/$(_PROJECT_NPM).$${_program}.1"; \
	done; \

build-npm:

	make \
	  build-man
	cp \
	  -r \
	  $(NPM_FILES) \
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

eslint:

	npm \
	  run \
	    lint

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

install-node-scripts:

	for _file in $(_NODE_FILES); do \
	  $(_INSTALL_EXE) \
	  "$${_file}" \
	  "$(LIB_DIR)/$${_file}"; \
	done

install-man:

	$(_INSTALL_DIR) \
	  "$(MAN_DIR)/man1"
	for _file in $(_BASH_FILES); do \
	  rst2man \
	    "man/$${_file}.1.rst" \
	    "$(MAN_DIR)/man1/$${_file}.1"; \
	done

install-npm:

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
	    "$(_PROJECT_NPM)-$${_version}.tgz"; \
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

	for _file in $(_NODE_FILES); do \
	  rm \
	    -r \
	    "$(LIB_DIR)/$${_file}"; \
	done

.PHONY: $(_PHONY_TARGETS)
