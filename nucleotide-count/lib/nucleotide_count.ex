defmodule NucleotideCount do
  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide) do
    List.foldl(strand, 0, fn (ch, sum) ->
      if ch == nucleotide do
        sum + 1
      else
        sum
      end
    end)
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram(charlist()) :: map()
  def histogram(strand) do(
    List.foldl(strand, %{?A => 0, ?T => 0, ?C => 0, ?G => 0}, fn(ch, histogram) ->
      Map.put(histogram, ch, Map.get(histogram, ch, 0) + 1)
    end))
  end
end
