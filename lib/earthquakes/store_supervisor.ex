defmodule Earthquakes.StoreSupervisor do
  use Supervisor

  alias Earthquakes.Earthquake

  @url "https://everyearthquake.p.rapidapi.com/earthquakes"
  @api_key "bdeed85c45mshc824fcec60a8d85p1c2370jsn2244d33b9202"
  @host "everyearthquake.p.rapidapi.com"

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg,  name: __MODULE__)
  end

  def init(_init_arg) do

    earthquakes =
      fetch_earthquakes()
      |> format_earthquakes()
      |> Enum.map(fn earthquake -> add_earthquake(earthquake) end)

    Supervisor.init(Enum.take(earthquakes, 5), strategy: :one_for_one)
  end

  defp add_earthquake(%Earthquake{} = store) do
    %{
      id: String.to_atom(store.location),
      start: {Earthquakes.EarthquakeServer, :start_link, [store]}
    }
  end

  defp fetch_earthquakes() do
    headers = [
      {"X-RapidAPI-Key", @api_key},
      {"X-RapidAPI-Host", @host}
    ]

    params = [
      start: "1",
      count: "3",
      type: "earthquake",
      latitude: "33.962523",
      longitude: "-118.3706975",
      radius: "1000",
      units: "miles",
      magnitude: "3",
      intensity: "1"
    ]



    res = HTTPoison.get!(@url, headers, params)

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
