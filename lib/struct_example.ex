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
          name: String.t() | nil,
          works?: boolean()
        }

  @spec new(id: integer) :: t
  def new(id) when is_integer(id), do: %StructExample{id: id}

  @spec new(id: integer, name: String.t()) :: t
  def new(id, name) when is_integer(id) and is_binary(name),  do: %StructExample{id: id, name: name}

  @spec new(id: integer, name: String.t() | nil, works: boolean) :: t
  def new(id, name, works) when is_integer(id) and (is_binary(name) or name == nil) and is_boolean(works) do
   case name do
    name when is_binary(name) -> %StructExample{id: id, name: name, works?: works}
    _ -> %StructExample{id: id, works?: works}
   end
  end

  @spec get_name(example: t) :: String.t()
  def get_name(example) do
    %StructExample{name: name} = example
    case name do
      name when is_binary(name) -> name
      _ -> "No name"
    end
  end
end
