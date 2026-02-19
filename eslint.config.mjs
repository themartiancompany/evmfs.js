import js from "@eslint/js";
import globals from "globals";
import { defineConfig } from "eslint/config";

const
  _configs = [
    {
      files:
        [ "**/*.{js,mjs,cjs}" ],
      plugins:
        { js },
      extends:
        [ "js/recommended" ],
      languageOptions:
        { globals:
            { ...globals.browser,
              ...globals.node } } },
    { files:
        ["**/*.js"],
      languageOptions:
        { sourceType:
          "commonjs" } },
  ];

export default defineConfig(
  _configs);
