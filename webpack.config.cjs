const
  _path =
    require(
      'path');
const
  _output_dir =
    _path.resolve(
      __dirname);
const
  _input_file_name =
    "evmfs/evmfs.js.get";
const
  _output_file_name =
    `${_input_file_name}.js`;
const
  _input_file_path =
    `./${_input_file_name}/${_input_file_name}`;
const
  _web_worker_ignore =
  { resourceRegExp:
      /^web-worker$/ };
const
  _yargs_ignore =
  { resourceRegExp:
      /^yargs$/ };
const
  _yargs_helpers_ignore = {
    resourceRegExp:
      /^yargs\/helpers$/
};
const
  _webpack =
    require(
     "webpack");
const
  _ignore_plugin =
    _webpack.IgnorePlugin; 
const
  _yargs_ignore_plugin =
    new _ignore_plugin(
          _yargs_ignore);
const
  _yargs_helpers_ignore_plugin =
    new _ignore_plugin(
          _yargs_helpers_ignore);
const
  _output =
  { path:
      _output_dir,
    filename:
      _output_file_name };
module.exports = {
  entry:
    _input_file_path,
  output:
    _output,
  optimization: {
    moduleIds: 'deterministic',
  },
  resolve: {
    alias: {
      "fs":
        _path.resolve(
          __dirname,
          'node_modules/fs/fs'),
      "path":
        _path.resolve(
          __dirname,
          'node_modules/path/mod.js'),
      "web-worker":
        _path.resolve(
          __dirname,
          'node_modules/web-worker/dist/browser/index.cjs'),
    },
    fallback: {
      "utils":
        false
    },
  },
  externals:
    { yargs:
        'yargs' },
  plugins: [
    _yargs_ignore_plugin,
    _yargs_helpers_ignore_plugin
  ]
};
