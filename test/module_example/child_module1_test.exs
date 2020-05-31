defmodule ModuleExample.ChildModule1Test do
  use ExUnit.Case
  doctest ModuleExample.ChildModule1

  test "name of the module" do
    assert ModuleExample.ChildModule1.name() == ModuleExample.ChildModule1
  end
end
