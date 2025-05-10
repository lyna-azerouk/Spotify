defmodule SpotifyApiWeb.ArtistController do
  @moduledoc false
  use SpotifyApiWeb, :controller
  alias SpotifyApi.Artists

  def index(conn, %{"name" => name}) do
    case Artists.maybe_create_artist(name) do
      {:ok, artist} ->
        conn
        |> put_status(:created)
        |> json(%{artist: artist})

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(changeset)
    end
  end
end
