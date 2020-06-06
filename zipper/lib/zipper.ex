defmodule Zipper do

  @type t :: %Zipper{root: BinTree.t(), focus: BinTree.t(), path: [{BinTree.t(), :left | :right}] }

  defstruct [:root, :path, :focus]
  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(bin_tree) do
    %Zipper{root: bin_tree, focus: bin_tree, path: []}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree(zipper) do
    zipper.root
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value(zipper) do
    zipper.focus.value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left(zipper) do
    if zipper.focus.left do
      %{ %{zipper | path: [{zipper.focus, :left} | zipper.path]} | focus: zipper.focus.left}
    end
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right(zipper) do
    if zipper.focus.right do
      %{ %{zipper | path: [{zipper.focus, :right} | zipper.path]} | focus: zipper.focus.right}
    end
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up(zipper) do
    if zipper.path != [] do
      [{parent, _} | ancestors] = zipper.path
      %{%{zipper | focus: parent} | path: ancestors}
    end
  end

  defp update_zipper(zipper) do
    %{path: new_path, current: new_root} = List.foldl(zipper.path, %{path: [], current: zipper.focus }, fn ({node, direction}, acc) ->
      new_node = Map.put(node, direction, acc.current)
      %{%{acc | path: {new_node, direction}} | current: new_node}
    end )
    %{%{zipper | path: new_path} | root: new_root}
  end
  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value(zipper, value) do
    update_zipper(%{zipper | focus: %{ zipper.focus | value: value}})
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left(zipper, left) do
    update_zipper(%{zipper | focus: %{ zipper.focus | left: left}})
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(zipper, right) do
    update_zipper(%{zipper | focus: %{ zipper.focus | right: right}})
  end
end
