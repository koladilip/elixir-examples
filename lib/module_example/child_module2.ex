defmodule ModuleExample.ChildModule2 do
  @moduledoc """
  Documentation for `ModuleExample.ChildModule2`.
  """

  @doc """
  Name of the module

  ## Examples

      iex> ModuleExample.ChildModule2.name()
      ModuleExample.ChildModule2

  """

  def name(), do: __MODULE__

end