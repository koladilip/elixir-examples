defmodule StructExample do
  @moduledoc """
  A struct representing a Example.
  """

  @enforce_keys [:id]
  defstruct id: nil,
            name: nil,
            works?: true

  @typedoc "An example"
  @type t :: %__MODULE__{
          id: non_neg_integer(),
          name: String.t | nil,
          works?: boolean()
        }

 @doc """
  New example struct with id

  ## Examples

      iex> StructExample.new(1)
      %StructExample{id: 1}

  """
  @spec new(id: integer) :: t
  def new(id) when is_integer(id), do: %StructExample{id: id}

 @doc """
  New example struct with id and name

  ## Examples

      iex> StructExample.new(1, "hello")
      %StructExample{id: 1, name: "hello"}

  """
  @spec new(id: integer, name: String.t) :: t
  def new(id, name) when is_integer(id) and is_binary(name),  do: %StructExample{id: id, name: name}

  @doc """
  New example struct with id, name and works

  ## Examples

      iex> StructExample.new(1, "hello", true)
      %StructExample{id: 1, name: "hello", works?: true}

      iex> StructExample.new(1, nil, true)
      %StructExample{id: 1, works?: true}

  """
  @spec new(id: integer, name: String.t | nil, works: boolean) :: t
  def new(id, name, works) when is_integer(id) and (is_binary(name) or name == nil) and is_boolean(works) do
   case name do
    name when is_binary(name) -> %StructExample{id: id, name: name, works?: works}
    _ -> %StructExample{id: id, works?: works}
   end
  end

  @doc """
  Gets the name of the example

  ## Examples

      iex> StructExample.get_name(%StructExample{id: 1, name: "hello", works?: true})
      "hello"

      iex> StructExample.get_name(%StructExample{id: 1, works?: true})
      "No name"

      iex> StructExample.get_name(%StructExample{id: 1})
      "No name"

  """

  @spec get_name(example: t) :: String.t
  def get_name(example) do
    %StructExample{name: name} = example
    case name do
      name when is_binary(name) -> name
      _ -> "No name"
    end
  end
end
