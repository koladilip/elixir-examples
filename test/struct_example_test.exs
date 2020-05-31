defmodule StructExampleTest do
  use ExUnit.Case
  doctest StructExample

  test "new example struct with id" do
    assert StructExample.new(32) == %StructExample{id: 32}
  end

  test "new example struct with id and name" do
    assert StructExample.new(32, "Example") == %StructExample{id: 32, name: "Example"}
  end

  test "new example struct with id and name and works" do
    assert StructExample.new(32, "Example", true) == %StructExample{id: 32, name: "Example", works?: true}
  end

  test "gets name from struct when name is defined" do
    assert StructExample.get_name(StructExample.new(32, "Example", true)) == "Example"
    assert StructExample.get_name(StructExample.new(32, "Example")) == "Example"
  end

  test "gets name from struct when name is undefined" do
    assert StructExample.get_name(StructExample.new(32)) == "No name"
  end

  test "gets name from struct when name is nil" do
    assert StructExample.get_name(StructExample.new(32, nil, true)) == "No name"
  end
end
