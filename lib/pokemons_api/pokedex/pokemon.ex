defmodule PokemonsApi.Pokedex.Pokemon do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "pokemons" do
    field :name, :string
    field :number, :integer

    timestamps()
  end

  @doc false
  def changeset(pokemon, attrs) do
    pokemon
    |> cast(attrs, [:name, :number])
    |> validate_required([:name, :number])
    |> unique_constraint(:number)
  end
end
