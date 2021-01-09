defmodule PokemonsApiWeb.PokemonControllerTest do
  use PokemonsApiWeb.ConnCase

  alias PokemonsApi.Pokedex
  alias PokemonsApi.Pokedex.Pokemon

  @create_attrs %{
     name: "some  name",
    number: 42
  }
  @update_attrs %{
     name: "some updated  name",
    number: 43
  }

  def fixture(:pokemon) do
    {:ok, pokemon} = Pokedex.create_pokemon(@create_attrs)
    pokemon
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all pokemons", %{conn: conn} do
      conn = get(conn, Routes.pokemon_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create pokemon" do
    test "renders pokemon when data is valid", %{conn: conn} do
      conn = post(conn, Routes.pokemon_path(conn, :create), pokemon: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.pokemon_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some  name",
               "number" => 42
             } = json_response(conn, 200)["data"]
    end
  end

  describe "update pokemon" do
    setup [:create_pokemon]

    test "renders pokemon when data is valid", %{conn: conn, pokemon: %Pokemon{id: id} = pokemon} do
      conn = put(conn, Routes.pokemon_path(conn, :update, pokemon), pokemon: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.pokemon_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some updated  name",
               "number" => 43
             } = json_response(conn, 200)["data"]
    end
  end

  describe "delete pokemon" do
    setup [:create_pokemon]

    test "deletes chosen pokemon", %{conn: conn, pokemon: pokemon} do
      conn = delete(conn, Routes.pokemon_path(conn, :delete, pokemon))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.pokemon_path(conn, :show, pokemon))
      end
    end
  end

  defp create_pokemon(_) do
    pokemon = fixture(:pokemon)
    %{pokemon: pokemon}
  end
end
