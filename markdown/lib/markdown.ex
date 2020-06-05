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
      current_list -> full_list ++ [current_list]
    end
  end

  defp split_markdown(m) do
   lines = String.split(m, "\n")
   {full_list, current_list} = List.foldl(lines, {[], []}, fn (line, {fl, cl}) ->
    cond do
      String.starts_with?(line, "*") -> {fl, cl ++ [line]}
      true -> {merge_lists({fl, cl}) ++ [line], []}
    end
   end )
   merge_lists({full_list, current_list})
  end

  defp process(t) do
    cond do
      is_list(t) -> parse_list_md_level(t)
      String.starts_with?(t, "#") -> enclose_with_header_tag(parse_header_md_level(t))
      true -> enclose_with_paragraph_tag(String.split(t))
    end
  end

  defp parse_header_md_level(hwt) do
    [h | t] = String.split(hwt)
    {String.length(h), Enum.join(t, " ")}
  end

  defp parse_list_md_level(l) do
    "<ul>" <> Enum.map_join(l, fn t ->
      "<li>#{join_words_with_tags(String.split(String.trim_leading(t, "* ")))}</li>"
    end) <> "</ul>"
  end

  defp enclose_with_header_tag({hl, htl}) do
    "<h#{hl}>#{htl}</h#{hl}>"
  end

  defp enclose_with_paragraph_tag(t) do
    "<p>#{join_words_with_tags(t)}</p>"
  end

  defp join_words_with_tags(t) do
    Enum.map_join(t, " ", fn w -> replace_md_with_tag(w) end)
  end

  defp replace_md_with_tag(w) do
    replace_suffix_md(replace_prefix_md(w))
  end

  defp replace_prefix_md(w) do
    String.replace(String.replace(w, ~r/^__/, "<strong>"), ~r/^_/, "<em>")
  end

  defp replace_suffix_md(w) do
    String.replace(String.replace(w, ~r/__$/, "</strong>"), ~r/_$/, "</em>")
  end
end
