defmodule ModuleExample do
  @moduledoc """
  Documentation for `ModuleExample`.
  """

  @doc """
  Name of the module

  ## Examples

      iex> ModuleExample.name()
      ModuleExample

  """

  def name(), do: __MODULE__

  def child_module1(), do: ModuleExample.ChildModule1.name()

  def child_module2(), do: ModuleExample.ChildModule2.name()

end
