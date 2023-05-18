defmodule Earthquakes do
  @moduledoc """
  Documentation for `Earthquakes`.
  """

  @enforce_keys [:location, :lat, :lng]
  defstruct [:location, :lat, :lng]
end
