defmodule SecretHandshake do

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    digits = Integer.digits(rem(code, 32), 2)
    case length(digits) do
      5 ->
        [_ | tail] = digits
        commands_internal(tail)
      _ -> Enum.reverse(commands_internal(digits))
    end
  end

  defp commands_internal(digits) do
    [head | tail] = digits
    case {head, length(tail)} do
      {0, 0} -> []
      {0, _} -> commands_internal(tail)
      {1, 3} -> ["jump" |  commands_internal(tail) ]
      {1, 2}-> ["close your eyes" |  commands_internal(tail) ]
      {1, 1} -> ["double blink" |  commands_internal(tail) ]
      {1, 0} -> ["wink"]
    end
  end
end
