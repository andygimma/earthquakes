defmodule Earthquakes.EarthquakeServer do
  use GenServer

  alias Earthquakes.Earthquake
  alias Earthquakes.StoreSupervisor

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

  def list_all(lat, lng) do
    Earthquakes.StoreSupervisor
    |> Supervisor.which_children()
    |> Enum.reduce([], fn {_, item_pid, _, _}, acc ->
      [item_pid | acc]
    end)
    |> Enum.map(fn pid ->
      :sys.get_state(pid)
    end)
    |> generate_distances(lat, lng, %{})
    |> Enum.sort(fn ({_k1, val1}, {_k2, val2}) -> val1 <= val2 end)
  end

  def generate_distances([], _, _, acc) do
    acc
  end
  def generate_distances(list, lat, lng, acc) do
    [h | t] = list
    acc = Map.put(acc, h.location, calculate_distance(h, lat, lng))
    generate_distances(t, lat, lng, acc)
  end

  def calculate_distance(%Earthquake{} = earthquake, lat, lng) do
    :rand.uniform(1000)
  end
end
