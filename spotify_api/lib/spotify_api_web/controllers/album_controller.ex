defmodule SpotifyApiWeb.AlbumController do
  @moduledoc false
  use SpotifyApiWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias SpotifyApi.Artists
  alias SpotifyApiWeb.Schemas.AlbumsResponse

  tags(["albums"])

  operation(:index,
    summary: "Retrieve list of albums by artist name",
    parameters: [
      %OpenApiSpex.Parameter{
        name: :name,
        in: :path,
        required: true,
        description: "Name of the artist"
      }
    ],
    responses: %{
      200 => {"OK", "application/json", AlbumsResponse.schema()}
    }
  )

  def index(conn, %{"name" => name}) do
    case Artists.maybe_create_artist(name) do
      {:ok, artist} ->
        conn
        |> put_status(:created)
        |> put_resp_content_type("application/json")
        |> json(%{artist: artist})

      {:error, changeset} ->
        # IO.inspect(changeset, label: "Error creating artist")
        conn
        |> put_status(:unprocessable_entity)
        |> json(changeset)
    end
  end
end
