defmodule ModuleExample.ChildModule2Test do
  use ExUnit.Case
  doctest ModuleExample.ChildModule2

  test "name of the module" do
    assert ModuleExample.ChildModule2.name() == ModuleExample.ChildModule2
  end
end
