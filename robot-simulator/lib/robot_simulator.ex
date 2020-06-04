defmodule RobotSimulator do
  defp is_valid_position(position) do
    is_tuple(position) && tuple_size(position) == 2 && Enum.all?(Tuple.to_list(position), &(is_integer(&1)))
  end

  defp list_contains(list, item) do
    Enum.any?(list, &(&1 == item))
  end

  defp next_direction(direction, move) do
    case {direction, move} do
      {:north, ?L} -> :west
      {:north, ?R} -> :east
      {:east, ?L} -> :north
      {:east, ?R} -> :south
      {:south, ?L} -> :east
      {:south, ?R} -> :west
      {:west, ?L} -> :south
      {:west, ?R} -> :north
    end
  end

  defp next_position(position, direction) do
    {x, y} = position
    case direction do
      :north -> {x, y + 1}
      :east -> {x + 1, y}
      :south -> {x, y - 1}
      :west -> {x - 1, y}
    end
  end
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """

  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0}) do
    valid_directions = [:north, :east, :south, :west]
    cond do
     !list_contains(valid_directions, direction) -> {:error, "invalid direction"}
     !is_valid_position(position) -> {:error, "invalid position"}
     true -> %{direction: direction, position: position}
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    char_list = String.to_charlist(instructions)
    cond do
      Enum.all?(char_list, &(list_contains('ALR', &1))) -> List.foldl(char_list, robot, fn(char, robot) ->
        cond do
          char == ?L || char == ?R -> %{robot | direction: next_direction(robot[:direction], char) }
          char == ?A -> %{robot | position: next_position(robot[:position], robot[:direction]) }
          true -> robot
        end
      end)
      true -> {:error, "invalid instruction"}
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    Map.get(robot, :direction)
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    Map.get(robot, :position)
  end
end
