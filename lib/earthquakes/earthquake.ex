defmodule Earthquakes.Earthquake do
  @enforce_keys [:location, :lat, :lng, :timestamp]
  defstruct [:location, :lat, :lng, :timestamp]
end
