#!/usr/bin/env node

// SPDX-License-Identifier: AGPL-3.0-or-later

/**    ----------------------------------------------------------------------
 *     evmfs.js
 *     ----------------------------------------------------------------------
 *     Copyright ©
 *       Pellegrino Prevete
 *         2024, 2025, 2026
 * 
 *     All rights reserved
 *     ----------------------------------------------------------------------
 * 
 *     This program is free software: you can redistribute it and/or modify
 *     it under the terms of the GNU General Public License as published by
 *     the Free Software Foundation, either version 3 of the License, or
 *     (at your option) any later version.
 * 
 *     This program is distributed in the hope that it will be useful,
 *     but WITHOUT ANY WARRANTY; without even the implied warranty of
 *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *     GNU General Public License for more details.
 * 
 *     You should have received a copy of the GNU General Public License
 *     along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */


const
  _ccget_module =
    require(
      "./evmfs.js.ccget");
_ccget =
  _ccget_module._ccget;
const
  _check_module =
    require(
      "./evmfs.js.check");
_check =
  _check_module._ccget;
const
  _get_module =
    require(
      "./evmfs.js.get");
_get =
  _get_module._get;
const
  _index_module =
    require(
      "./evmfs.js.index");
_index =
  _index_module._index;
const
  _lock_module =
    require(
      "./evmfs.js.lock");
_lock =
  _lock_module._lock;
const
  _lengthlock_module =
    require(
      "./evmfs.js.lengthlock");
_length =
  _lengthlock_module._lengthlock;
const
  _publish_module =
    require(
      "./evmfs.js.publish");
_publish =
  _publish_module._publish;
const
  _publish_bulk_module =
    require(
      "./evmfs.js.publish.bulk");
_publish_bulk =
  _publish_bulk_module._publish_bulk;
const
  _verify_module =
    require(
      "./evmfs.js.verify");
_verify =
  _verify_module._verify;

function
  _global_variables() {
  app_name =
    "evmfs.js";
  retries_max =
    "";
  api_key_path =
    "";
  target_network =
    "";
  deployments_dir =
    "";
  fs_version =
    "";
  rpc_selection =
    "";
  contract_address =
    "";
  contract_abi_path =
    "";
  contract_bytecode_path =
    "";
  contract_compiler_output_path =
    "";
  method_objects =
    {};
  publication_namespace =
    "";
  file_hash =
    "";
  index_start =
    "";
  index_end =
    "";
  checkpoint_file_path =
    "";
  chunks_files_paths =
    [];
  quiet =
    "";
}

async function
  _evmfs(
    _stub
  ) {
  let
    _msg;
  _msg =
    "stub";
  _msg_info(
  _msg);
}

function
  _overrides_set() {
  if ( rpc_selection == "" ) {
    rpc_selection =
      "kirsh";
  }
}

function
  _usage(
    _exit) {
  let
    _line,
    _text;
  _text = [
    "Hello.",
  for ( _line of _text ) {
    _msg_info(
      _line);
  }
  process.exit(
    _exit);
}


function 
  _cmdline_parse() {
  quiet = 
    "y";
  process.argv.forEach(
    function (
      _value,
      _index,
      _array) {
      if ( _index == 2 ) {
        quiet =
          _value;
      }
      if ( _index == 3 ) {
        retries_max =
          _value;
      }
      if ( _index == 4 ) {
        api_key_path =
          _value;
      }
      if ( _index == 5 ) {
        target_network =
          _value;
      }
      if ( _index == 6 ) {
        deployments_dir =
          _value;
      }
      if ( _index == 7 ) {
        fs_version =
          _value;
      }
      if ( _index == 8 ) {
        rpc_selection =
          _value;
      }
      if ( _index == 9 ) {
        contract_address =
          _value;
      }
      if ( _index == 10 ) {
        contract_abi_path =
          _value;
      }
      if ( _index == 11 ) {
        contract_bytecode_path =
          _value;
      }
      if ( _index == 12 ) {
        contract_compiler_output_path =
          _value;
      }
      if ( _index == 13 ) {
        publication_namespace =
          _value;
      }
      if ( _index == 14 ) {
        file_hash =
          _value;
      }
      if ( _index == 15 ) {
        index_start =
          _value;
      }
      if ( _index == 16 ) {
        index_end =
          _value;
      }
      if ( _index == 17 ) {
        checkpoint_file_path =
          _value;
      }
      if ( 17 < _index ) {
        chunks_files_paths.push(
          _value);
      }
      if ( _value == "-h" ||
           _value == "--help" ) {
        _usage(
	  0);
      }
  });
  if ( file_hash == "" ||
       publication_namespace == "" ) {
    _usage(
      1);
  }
}

if ( _cmdline_check(
       "evmfs.js") ) {
  _global_variables();
  _cmdline_parse();
  _overrides_set();
  _config_show();
  app_opts = [
    retries_max,
    api_key_path,
    target_network,
    deployments_dir,
    fs_version,
    rpc_selection,
    contract_address,
    contract_abi_path,
    contract_bytecode_path,
    contract_compiler_output_path,
    method_objects,
    publication_namespace,
    file_hash,
    index_start,
    index_end,
    checkpoint_file_path,
    chunks_files_paths,
  ];
  _evmfs.apply(
    null,
    app_opts);
}

module.exports = {
  _chain_id_read:
    _chain_id_read,
  _fs_address_read:
    _fs_address_read,
  _ccget:
    _ccget,
  _chunk_check:
    _chunk_check,
  _chunk_get:
    _chunk_get,
  _chunk_publish:
    _chunk_publish,
  _chunks_publish_bulk:
    _chunks_publish_bulk,
  _check:
    _check,
  _index:
    _index,
  _get:
    _get,
  _lock:
    _lock,
  _publish:
    _publish,
  _publish_bulk:
    _publish_bulk,
  _references_read:
    _references_read,
  _verify:
    _verify
};
