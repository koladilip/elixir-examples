defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l) do
    case l do
      [] -> 0
      [_head | tail] -> 1 + count(tail)
    end
  end

  defp reverse(l, acc) do
    case l do
      [] -> acc
      [head | tail] -> reverse(tail, [head | acc ])
    end
  end

  @spec reverse(list) :: list
  def reverse(l) do
    case l do
      [] -> []
      [head | tail] -> reverse(tail, [head])
    end
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    case l do
      [] -> []
      [head | tail] -> [f.(head) | map(tail, f)]
    end
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    case l do
      [] -> []
      [head | tail] -> cond do
        f.(head) -> [head | filter(tail, f)]
        true -> filter(tail, f)
      end
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce(l, acc, f) do
    case l do
      [] -> acc
      [head | tail] -> f.(head, reduce(tail, acc, f))
    end
  end

  @spec append(list, list) :: list
  def append(a, b) do
    case {a, b} do
      {[], []} -> []
      {a, []} -> a
      {[], b} -> b
      {[head | tail], b} -> [head | append(tail, b)]
    end
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    case ll do
      [] -> []
      [head | tail] -> append(head, concat(tail))
    end
  end
end
