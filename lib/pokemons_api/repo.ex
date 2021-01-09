defmodule PokemonsApi.Repo do
  use Ecto.Repo,
    otp_app: :pokemons_api,
    adapter: Ecto.Adapters.Postgres
end
