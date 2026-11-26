// SPDX-License-Identifier: GPL-3.0-or-later

/**    ------------------------------------------------------------------
 *     Copyright ©
 *       Pellegrino Prevete
 *         2024, 2025, 2026
 * 
 *     All rights reserved
 *     ------------------------------------------------------------------
 * 
 *     This program is free software: you can redistribute it and/or
 *     modify it under the terms of the GNU General Public License as
 *     published by the Free Software Foundation, either version 3 of
 *     the License, or (at your option) any later version.
 * 
 *     This program is distributed in the hope that it will be useful,
 *     but WITHOUT ANY WARRANTY; without even the implied warranty of
 *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *     GNU General Public License for more details.
 * 
 *     You should have received a copy of the GNU General Public License
 *     along with this program.
 *     If not, see <https://www.gnu.org/licenses/>.
 */

import js from "@eslint/js";
import globals from "globals";
import { defineConfig } from "eslint/config";

function
  _lib_add(
    _files,
    _libs) {
  let
    _file;
  for ( _file of _libs ) {
    _files.push(
      _file);
  }
  return _files;
}

const
  _project =
    "evmfs";
const
  _ignores = [
     "build/**",
     "dist/**",
     `**/*.${_project}.js`,
     `**/*.lib${_project}.js`,
     "node_modules/**",
     "eslint.config.js",
     "man/**"
  ];
const
  _libs = [
    "ccget",
    "check",
    "common",
    "get"
    "index",
    "lengthlock",
    "lock",
    "publish",
    "publish_bulk",
    "verify"
  ];
const
  _files = [
     "**/*.{js,mjs,cjs}",
     `**/${_project}*`,
     `**/lib/*`,
     `**/lib/**`,
     `**/lib${_project}`
  ];
const
  _files_mjs =
    _lib_add(
      _files,
      _libs);

export default defineConfig([
 {
   ignores:
     _ignores,
   rules:
     { semi:
         "error",
       "prefer-const":
         "error" },
   files:
     _files_mjs,
   plugins:
     { js },
   extends:
     [ "js/recommended" ],
   languageOptions:
     { globals:
         {  ...globals.browser,
            ...globals.node } } },
 { 
   ignores:
     _ignores,
   rules:
     { semi:
         "error",
       "prefer-const":
         "error" },
   files:
     [ "**/*.{cjs,js}" ],
   languageOptions:
     { sourceType:
         "commonjs" } },
]);
