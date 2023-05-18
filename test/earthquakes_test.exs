defmodule EarthquakesTest do
  use ExUnit.Case
  doctest Earthquakes

  test "greets the world" do
    assert Earthquakes.hello() == :world
  end
end
