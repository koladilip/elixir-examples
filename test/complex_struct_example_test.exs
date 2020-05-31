defmodule ComplexStructExampleTest do
  use ExUnit.Case
  doctest ComplexStructExample

  test "new example struct with category" do
    assert ComplexStructExample.new("sample") == %ComplexStructExample{category: "sample", examples: []}
  end

  test "new example struct with category as number" do
    assert_raise FunctionClauseError, fn ->
      ComplexStructExample.new(1)
    end
  end

  test "add example" do
    complex_example = ComplexStructExample.new("sample")
    complex_example = ComplexStructExample.add_example(complex_example, StructExample.new(1))
    assert complex_example == %ComplexStructExample{category: "sample", examples: [%StructExample{id: 1}]}
  end
end
