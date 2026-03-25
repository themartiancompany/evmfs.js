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
    "fs-worker";
const
  _input_file_path =
    `./node_modules/opfs/${_input_file_name}`;
const
  _output_file_name =
    `${_input_file_name}.js`;
_output = {
  path:
    _output_dir,
  filename:
    _output_file_name
};
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
      "opfs":
        _path.resolve(
          __dirname,
          'node_modules/fs/fs'),
      "path":
        _path.resolve(
          __dirname,
          'node_modules/path/mod.js'),
    },
  }
};
