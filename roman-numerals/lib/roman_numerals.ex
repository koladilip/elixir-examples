defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    cond do
      number >= 1000 -> String.duplicate("M", div(number, 1000)) <> numeral(rem(number, 1000))
      number >= 900 -> "CM" <> numeral(number-900)
      number >= 500 -> "D" <> numeral(number-500)
      number >= 400 -> "CD" <> numeral(number-400)
      number >= 100 -> String.duplicate("C", div(number, 100)) <> numeral(rem(number, 100))
      number >= 90 -> "XC" <> numeral(number-90)
      number >= 50 -> "L" <> numeral(number-50)
      number >= 40 -> "XL" <> numeral(number-40)
      number >= 10 -> String.duplicate("X", div(number, 10)) <> numeral(rem(number, 10))
      number == 9 -> "IX"
      number >= 5 -> "V" <> numeral(number-5)
      number == 4 -> "IV"
      number >= 1 -> String.duplicate("I", number)
      number <= 0 -> ""
    end
  end
end
