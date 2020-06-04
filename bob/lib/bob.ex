defmodule Bob do
  def hey(input) do
    input_trimmed = String.trim(input)
    is_empty? = input_trimmed == ""
    ends_with? = String.ends_with?(input_trimmed, "?")
    is_downcase? = !is_empty? && input_trimmed == String.downcase(input_trimmed)
    is_upcase? = !is_empty? && !is_downcase? && input_trimmed == String.upcase(input_trimmed)
    cond do
      is_upcase? && ends_with? -> "Calm down, I know what I'm doing!"
      is_upcase? -> "Whoa, chill out!"
      ends_with? -> "Sure."
      is_empty? -> "Fine. Be that way!"
      true -> "Whatever."
    end
  end
end
