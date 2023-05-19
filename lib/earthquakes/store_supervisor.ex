defmodule Earthquakes.StoreSupervisor do
  use Supervisor

  alias Earthquakes.Earthquake

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg,  name: __MODULE__)
  end

  def init(_init_arg) do

    earthquakes =
      fetch_earthquakes()
      |> format_earthquakes()
      |> Enum.map(fn earthquake -> add_earthquake(earthquake) end)


    IO.inspect(earthquakes, label: "EEEEEEEEE")
    children = [
      add_earthquake(%Earthquake{location: "Test1", lat: 2.0, lng: 2.0, timestamp: DateTime.utc_now()}),
      add_earthquake(%Earthquake{location: "Test2", lat: 0.0, lng: 0.0, timestamp: DateTime.utc_now()})
    ]

    IO.inspect(children, label: "CHILDREN")

    Supervisor.init(earthquakes, strategy: :one_for_one)
  end

  defp add_earthquake(%Earthquake{} = store) do
    %{
      id: String.to_atom(store.location),
      start: {Earthquakes.EarthquakeServer, :start_link, [store]}
    }
  end

  defp fetch_earthquakes() do
    url = "https://everyearthquake.p.rapidapi.com/earthquakes"
    api_key = "bdeed85c45mshc824fcec60a8d85p1c2370jsn2244d33b9202"
    host = "everyearthquake.p.rapidapi.com"
    headers = [
      {"X-RapidAPI-Key", api_key},
      {"X-RapidAPI-Host", host}
    ]

    params = [
      start: "1",
      count: "100",
      type: "earthquake",
      latitude: "33.962523",
      longitude: "-118.3706975",
      radius: "1000",
      units: "miles",
      magnitude: "3",
      intensity: "1"
    ]



    res = HTTPoison.get!(url, headers, params)

    Jason.decode!(res.body)
  end

  defp format_earthquakes(earthquakes) do
    earthquakes["data"]
    |> Enum.map(fn earthquake ->
      %Earthquake{
        lat: earthquake["latitude"],
        lng: earthquake["longitude"],
        location: earthquake["location"],
        timestamp: earthquake["date"]
      }
    end)
  end
end
