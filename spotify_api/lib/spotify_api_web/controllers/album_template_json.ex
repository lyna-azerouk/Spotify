defmodule SpotifyApiWeb.AlbumTemplateJSON do
  def index(%{artist: artist}) do
    %{
      artist: %{
        name: artist.name,
        albums:
          Enum.map(artist.albums, fn album ->
            %{
              name: album.name,
              spotify_id: album.spotify_id,
              release_date: album.release_date
            }
          end)
      }
    }
  end
end
