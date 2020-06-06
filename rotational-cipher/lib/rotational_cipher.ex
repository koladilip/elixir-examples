defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    List.to_string(Enum.map(String.to_charlist(text),
      fn (ch) -> rotate_char(ch, rem(shift, 26)) end))
  end

  defp rotate_char(ch, shift) do
    cond do
      65 <= ch and ch <= (90 - shift)  -> ch + shift
      (90 - shift) < ch and ch <= 90 -> ch + shift - 26
      97 <= ch and ch <= (122 - shift)  -> ch + shift
      122 - shift < ch and ch <= 122 -> ch + shift - 26
      true -> ch
    end
  end
end
