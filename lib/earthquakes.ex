defmodule Earthquakes do
  @moduledoc """
  Documentation for `Earthquakes`.
  """

  @enforce_keys [:location, :lat, :lng]
  defstruct [:location, :lat, :lng]

  @doc """
  Hello world.

  ## Examples

      iex> Earthquakes.hello()
      :world

  """
  def hello do
    :world
  end
end
