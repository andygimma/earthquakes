defmodule Earthquakes.StoreSupervisor do
  use Supervisor

  alias Earthquakes.Earthquake

  def start_link(init_arg) do
    IO.puts "1234555"
    Supervisor.start_link(__MODULE__, init_arg,  name: __MODULE__)
  end

  def init(_init_arg) do
    children = [
      create_store(%Earthquake{location: "Test1", lat: 2.0, lng: 0.0, timestamp: DateTime.utc_now()}),
      create_store(%Earthquake{location: "Test2", lat: 2.0, lng: 0.0, timestamp: DateTime.utc_now()})
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  defp create_store(%Earthquake{} = store) do
    %{
      id: String.to_atom(store.location),
      start: {Earthquakes.EarthquakeServer, :start_link, [store]}
    }
  end
end
