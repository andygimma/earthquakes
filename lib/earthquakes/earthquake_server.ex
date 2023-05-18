defmodule Earthquakes.EarthquakeServer do
  use GenServer

  alias Earthquakes.Earthquake

  def start_link(%Earthquake{} = earthquake) do
    GenServer.start_link(__MODULE__, earthquake, name: String.to_atom(earthquake.location))
  end

  @impl true
  def init(%Earthquake{} = earthquake) do
    {:ok, earthquake}
  end

  @impl true
  def handle_call(:earthquake, _from, %Earthquake{} = earthquake) do
    {:reply, earthquake, earthquake}
  end

  @impl true
  def handle_cast({:add_earthquake}, %Earthquake{} = earthquake) do
    earthquake =
      earthquake
      |> Map.put("#{earthquake.location}", earthquake)

    {:noreply, earthquake}
  end
end
