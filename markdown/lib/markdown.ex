defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(m) do
    Enum.map_join(split_markdown(m), fn t -> process(t) end)
  end

  defp merge_lists({full_list, current_list}) do
    case current_list do
      [] -> full_list
      current_list ->  [Enum.reverse(current_list) | full_list]
    end
  end

  defp split_markdown(m) do
   lines = String.split(m, "\n")
   {full_list, current_list} = List.foldl(lines, {[], []}, fn (line, {fl, cl}) ->
    cond do
      String.starts_with?(line, "*") -> {fl, [line | cl]}
      true -> {[line | merge_lists({fl, cl})], []}
    end
   end )
   Enum.reverse(merge_lists({full_list, current_list}))
  end

  defp process(t) do
    cond do
      is_list(t) -> parse_list_md_level(t)
      String.starts_with?(t, "#") -> parse_header_md_level(t)
      true -> parse_paragraph_md_level(String.split(t))
    end
  end

  defp parse_header_md_level(hwt) do
    [h | t] = String.split(hwt)
    Enum.join(t, " ") |> enclose_with_tag("h#{String.length(h)}")
  end

  defp parse_list_md_level(l) do
    Enum.map_join(l, fn t ->
      t |> String.trim_leading("* ") |> String.split()
      |> join_words_with_tags() |> enclose_with_tag("li")
    end) |> enclose_with_tag("ul")
  end

  defp parse_paragraph_md_level(l) do
    join_words_with_tags(l) |> enclose_with_tag("p")
  end

  defp enclose_with_tag(content, tag) do
    "<#{tag}>#{content}</#{tag}>"
  end

  defp join_words_with_tags(t) do
    Enum.map_join(t, " ", fn w -> replace_md_with_tag(w) end)
  end

  defp replace_md_with_tag(w) do
    w |> replace_prefix_md() |> replace_suffix_md()
  end

  defp replace_prefix_md(w) do
    w
    |>String.replace_prefix("__", "<strong>")
    |>String.replace_prefix("_", "<em>")
  end

  defp replace_suffix_md(w) do
    w
    |>String.replace_suffix("__", "</strong>")
    |>String.replace_suffix("_", "</em>")
  end
end
