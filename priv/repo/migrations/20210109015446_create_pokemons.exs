defmodule PokemonsApi.Repo.Migrations.CreatePokemons do
  use Ecto.Migration

  def change do
    create table(:pokemons, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :number, :integer

      timestamps()
    end

    create unique_index(:pokemons, [:number])
  end
end
