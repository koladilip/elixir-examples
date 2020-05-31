defmodule ComplexStructExample do
 @moduledoc """
  A struct representing examples organized using categories .
  """

  @enforce_keys [:category]
  defstruct [category: :default, examples: []]

  @typedoc "Categorized examples"
  @type t :: %__MODULE__{
          category: String.t,
          examples: [StructExample.t]
        }

 @doc """
  New Complex struct with category

  ## Examples

      iex> ComplexStructExample.new("sample")
      %ComplexStructExample{category: "sample", examples: []}

  """
  @spec new(category: String.t) :: t
  def new(category) when is_binary(category), do: %ComplexStructExample{category: category, examples: []}

  @spec add_example(t, StructExample.t) :: t
  def add_example(complex_example, example) do
    %{examples: examples} = complex_example
    examples = if examples do
      examples ++ [example]
    else
      [example]
    end
    %{complex_example | examples: examples}
  end
end
