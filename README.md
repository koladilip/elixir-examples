# Elixir Examples

## Modules directory structure
In this example, we will learn on how to name directories, files and module names.
* Directory/file names should be lower case with words separate using `_` (underscore).
  * [module_example.ex](https://github.com/koladilip/elixir-examples/blob/master/lib/module_example.ex) should be the file name for ModuleExample
  * [module_example/](https://github.com/koladilip/elixir-examples/tree/master/lib/module_example) should be the directory name for keeping the child modules of ModuleExample
* Module names should be in camel case. Parent and child modules are separated by `.` (dot), it shows hierarchy of the module tree. 
  * [ModuleExample](https://github.com/koladilip/elixir-examples/blob/master/lib/module_example.ex) is the parent module name.
  * [ModuleExample.ChildModule1](https://github.com/koladilip/elixir-examples/blob/master/lib/module_example/child_module1.ex) is the child module name.

