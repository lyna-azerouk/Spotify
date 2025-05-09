defmodule SpotifyApiWeb.ArtistController do
  @moduledoc false
  use SpotifyApiWeb, :controller
  alias SpotifyApi.Artists

  def index(conn, %{"name" => name}) do
    case Artists.get_artist_by_name(name) do
      nil ->
        Artists.fetch_and_create_artist(name)
        |> case do
          {:ok, artist} ->
            conn
            |> put_status(:created)
            |> json(artist)

          {:error, changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> json(changeset)
        end

      artist ->
        albums = Artists.get_artist_albums(artist.id)

        conn
        |> put_status(:ok)
        |> json(%{
          artist: %{
            name: artist.name,
            albums:
              albums
              |> Enum.map(fn album ->
                %{
                  name: album.name,
                  release_date: album.release_date
                }
              end)
          }
        })
    end
  end
end
