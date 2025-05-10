defmodule SpotifyApi.Artists do
  @doc """
  Context module for managing artists in the Spotify API.
  """

  alias SpotifyApi.Repo
  alias SpotifyApi.Modals.Artist
  alias SpotifyApi.Services.Spotify.Api

  def get_artist(id) do
    Artist
    |> Repo.get(id)
    |> Repo.preload(:albums)
  end

  def get_artist_by_spotify_id(spotify_id) do
    Artist
    |> Repo.get_by(spotify_id: spotify_id)
    |> Repo.preload(:albums)
  end

  def maybe_create_artist(artist_name) do
    case Api.search(artist_name) do
      {:ok, %{"artists" => %{"items" => [artist]}}} ->
        create_or_update_artist(get_artist_by_spotify_id(artist["id"]), artist)

      error ->
        error
    end
  end

  def create_or_update_artist(artist, attrs \\ nil)

  def create_or_update_artist(nil, attrs) do
    case fetch_albums(attrs["id"]) do
      {:ok, albums} ->
        create_artist(%{
          name: attrs["name"],
          spotify_id: attrs["id"],
          albums: albums
        })

      error ->
        error
    end
  end

  def create_or_update_artist(%Artist{spotify_id: spotify_id} = artist, _attrs) do
    case fetch_albums(spotify_id) do
      {:ok, albums} ->
        update_artist(artist, %{albums: albums})

      error ->
        error
    end
  end

  defp create_artist(attrs) do
    %Artist{}
    |> Artist.changeset(attrs)
    |> Repo.insert()
    |> IO.inspect(label: "Artist Created")
  end

  defp update_artist(artist, attrs) do
    artist
    |> Artist.changeset(attrs)
    |> Repo.update()
  end

  defp fetch_albums(artist_spotify_id) do
    case Api.get_artist_albums(artist_spotify_id) do
      {:ok, %{"items" => albums}} ->
        {:ok,
         Enum.map(
           albums,
           &%{
             name: &1["name"],
             release_date: &1["release_date"],
             spotify_id: &1["id"]
           }
         )}

      error ->
        error
    end
  end
end
