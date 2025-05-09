defmodule SpotifyApi.Artists do
  @doc """
  Context module for managing artists in the Spotify API.
  """

  alias SpotifyApi.Repo
  alias SpotifyApi.Modals.Artist
  alias SpotifyApi.Modals.Album
  alias SpotifyApi.Services.Spotify.Api

  def get_artist(id) do
    Repo.get(Artist, id)
  end

  def get_artist_by_name(name) do
    Repo.get_by(Artist, name: name)
  end

  def fetch_and_create_artist(artist_name) do
    Api.search(artist_name)
    |> case do
      {:ok, %{"artists" => %{"items" => [artist]}}} ->
        artist_id = artist["id"]
        artist_name = artist["name"]
        create_artist(%{name: String.downcase(artist_name), spotify_id: artist_id})

      _ ->
        {:error, "Artist not found"}
    end
  end

  defp create_artist(attrs) do
    %Artist{}
    |> Artist.changeset(attrs)
    |> Repo.insert()
  end

  def get_artist_albums(artist_id) do
    Album
    |> Repo.all()
    |> Repo.preload(:artist)
    |> Enum.filter(fn album -> album.artist_id == artist_id end)
  end

  def create_artist_albums(artist_id, albums) do
    Enum.each(albums, fn album ->
      %Album{}
      |> Album.changeset(%{
        name: album["name"],
        release_date: album["release_date"],
        spotify_id: album["id"],
        artist_id: artist_id
      })
      |> Repo.insert()
    end)
  end
end
