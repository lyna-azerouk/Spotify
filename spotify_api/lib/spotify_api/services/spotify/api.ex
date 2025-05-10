defmodule SpotifyApi.Services.Spotify.Api do
  @moduledoc """
  Module for handling Spotify API requests.
  """

  alias SpotifyApi.Services.Spotify.Config
  alias SpotifyApi.Services.Spotify.Authentification

  def search(artist_name) do
    with {:ok, bearer_token} <- Authentification.authenticate(),
         config <- Config.new(bearer_token),
         {:ok, %HTTPoison.Response{status_code: 200, body: body}} <-
           HTTPoison.get(
             "#{config.api_url}/search?type=artist&q=#{URI.encode(artist_name)}&limit=1",
             config.headers
           ) do
      {:ok, JSON.decode!(body)}
    else
      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
        {:error, "Search failed with status code: #{status_code}, body: #{body}"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Search failed with reason: #{inspect(reason)}"}
    end
  end

  def get_artist_albums(artist_id) do
    with {:ok, bearer_token} <- Authentification.authenticate(),
         config <- Config.new(bearer_token),
         {:ok, %HTTPoison.Response{status_code: 200, body: body}} <-
           HTTPoison.get("#{config.api_url}/artists/#{artist_id}/albums", config.headers) do
      {:ok, JSON.decode!(body)}
    else
      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
        {:error, "Get artist albums failed with status code: #{status_code}, body: #{body}"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Get artist albums failed with reason: #{inspect(reason)}"}
    end
  end
end
