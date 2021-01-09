defmodule PokemonsApiWeb.PokemonView do
  use PokemonsApiWeb, :view
  alias PokemonsApiWeb.PokemonView

  def render("index.json", %{pokemons: pokemons}) do
    %{data: render_many(pokemons, PokemonView, "pokemon.json")}
  end

  def render("show.json", %{pokemon: pokemon}) do
    %{data: render_one(pokemon, PokemonView, "pokemon.json")}
  end

  def render("pokemon.json", %{pokemon: pokemon}) do
    %{id: pokemon.id,
       name: pokemon. name,
      number: pokemon.number}
  end
end
