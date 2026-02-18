..
   SPDX-License-Identifier: AGPL-3.0-or-later

   ----------------------------------------------------------------------
   Copyright © 2024, 2025, 2026  Pellegrino Prevete

   All rights reserved
   ----------------------------------------------------------------------

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU Affero General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU Affero General Public License for more details.

   You should have received a copy of the GNU Affero General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.


================
evmfs.js.ccget
================

-------------------------------------------------------------------
Ethereum Virtual Machine Cross Chain File System download program
-------------------------------------------------------------------
:Version: evmfs.js.ccget |version|
:Manual section: 1


Synopsis
========

evmfs.js.ccget *quiet* *retries-max* *api-key-path* *target-network* *deployments-dir *fs-version* *rpc-selection* *contract-address* *contract-abi-path* *contract-bytecode-path* *contract-compiler-output-path *publication-namespace* *index-start* *file-hash* *index-start* *index-end* *checkpoint-file-path* *chunk-file-path*


Description
===========

Program used to retrieve files from the
Ethereum Virtual Machine File System (EVMFS).


Arguments
==========

*quiet*

  Can be 'y' or 'n'.
  Default: y
  
*retries-max*

  Maximum number of retries before",
  failing (not implemented).

*api-key-path*

  Path of the API key for the
  contract ABI provider service.

*target-network*

  Network on which the contract
  resides.

*deployments-dir*

  Contracts deployments directory.

*fs-version*

  Version of the target file
  system contract.
  Default: 1.0

*rpc-selection*

  RPC selection method.
  Default: first
  
*contract-address*

  Address of the contract.

*contract-abi-path*

  Contract ABI path.

*contract-bytecode-path*

  Path for the contract bytecode.

*contract-compiler-output-path*

  Path for the contract compiler
  output path (the hardhat artifact).

*publication-namespace*

  Namespace in which the file will be
  published.
  
*file-hash*

  Hash of the file to publish.

*index-start* 

  Chunk index from where to start.

*index-end*

  Final chunk index to download.
  
*checkpoint-file-path*

  Checkpoint file on which latest
  downloaded chunk index is saved
  in case node was to crash.

*[chunk_file_path]*

  Files in which to write the chunks.


Networks
========

The list of supported networks can be
consulted using *evm-chains-info*.
Public EVMFS contracts' deployments' networks,
versions and addresses available in this EVMFS
install can be consulted using *evm-deployment-networks*,
*evm-deployment-versions* and *evm-deployment-address*.
So for example to list all the public deployments'
addresses for the *FileSystem* EVMFS contract
one can type:

evm-deployment-address *-a* *evmfs* *FileSystem*

For further options, like for example
how to configure user-defined private
EVMFS deployments, refer to those programs' manuals.


Options
=======

-h                      Displays help message.
-v                      Enable verbose output


Bugs
====

https://github.com/themartiancompany/evmfs.js/-/issues


Copyright
=========

Copyright Pellegrino Prevete. AGPL-3.0.

See also
========

* evmfs.js.check
* evmfs.js.get
* evmfs.js.index
* evmfs.js.lengthlock
* evmfs.js.lock
* evmfs.js.publish
* evmfs.js.veryfy
* evmfs
* evmfs-publish
* evm-wallet

.. include:: variables.rst
