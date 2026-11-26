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
  _files = [
    "**/*.{js,mjs,cjs}",
    `**/${_project}*`,
    `**/lib/*`,
    `**/lib/**`,
    `**/lib${_project}`,
    `**/lib${_project}-get`,
    `**/lib${_project}-publish`,
    "**/lib/ccget",
    "**/lib/check",
    "**/lib/common",
    "**/lib/get",
    "**/lib/index",
    "**/lib/lengthlock",
    "**/lib/lock",
    "**/lib/publish",
    "**/lib/publish_bulk",
    "**/lib/verify"
  ];

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
     _files,
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
