defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    words = String.split(String.downcase(sentence), ~r{[!&@$%^&_:, ]}, trim: true)
    List.foldl(words, %{}, fn (word, word_count) ->  Map.update(word_count, word, 1, &(&1 + 1)) end)
  end
end
