defmodule SpotifyApiWeb.Schemas do
  require OpenApiSpex
  alias OpenApiSpex.Schema

  defmodule Album do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "Album",
      type: :object,
      properties: %{
        name: %Schema{type: :string, example: "Album Name"},
        spotify_id: %Schema{
          type: :string,
          example: "1234567890",
          description: "Spotify ID of the album"
        },
        release_date: %Schema{
          type: :string,
          format: :date,
          example: "2023-01-01",
          description: "Release date of the album"
        }
      }
    })
  end

  defmodule AlbumsResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "AlbumsResponse",
      description: "Response schema for albums by artist",
      type: :object,
      properties: %{
        artist: %Schema{
          type: :object,
          properties: %{
            name: %Schema{type: :string, example: "Artist Name"},
            albums: %Schema{
              type: :array,
              items: Album.schema()
            }
          }
        }
      },
      required: [:data]
    })
  end
end
