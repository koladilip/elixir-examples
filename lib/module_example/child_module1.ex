defmodule ModuleExample.ChildModule1 do
  @moduledoc """
  Documentation for `ModuleExample.ChildModule1`.
  """

  @doc """
  Name of the module

  ## Examples

      iex> ModuleExample.ChildModule1.name()
      ModuleExample.ChildModule1

  """

  def name(), do: __MODULE__

end