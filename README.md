# Earthquakes

Given a latitude and longitude, order the most recent earthquakes by distance.


https://github.com/andygimma/earthquakes/assets/2815544/0b128ad3-0682-4178-a3ae-1f8455b69692


## Goals

My goal here was to illustrate competence in several Elixir paradigms.

* OTP including supervisors
* Functional programming and use of Enum
* Clean code

## Tradeoffs and considerations

In a production app, I would use postgres for persistance and the PostGIS extension to efficiently do the distance calculations. I would however keep the GenServer as a cache.

## Getting started

Run these commands:

* `mix deps.get`
* `iex -S mix`
* `Earthquakes.EarthquakeServer.list_all 40.7484, 73.9857`

NOTE: The params are the latitude and longitude of the empire state building and can be changed to any coordinates.
WARNING: The app may not work if the API has a malformatted response. I did not want to experience scope creep in this coding sample. I added the video above as a proof-of-concept.

## Thank you

Thanks for taking the time to review this code. If there are any questions please email me or call me any time to discuss them.
