defmodule ModuleExampleTest do
  use ExUnit.Case
  doctest ModuleExample

  test "name of the module" do
    assert ModuleExample.name() == ModuleExample
  end

  test "name of the child module1" do
    assert ModuleExample.child_module1() == ModuleExample.ChildModule1
  end

  test "name of the child module2" do
    assert ModuleExample.child_module2() == ModuleExample.ChildModule2
  end
end
