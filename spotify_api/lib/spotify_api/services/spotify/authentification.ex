defmodule SpotifyApi.Services.Spotify.Authentification do
  @moduledoc """
  Module for handling Spotify API authentication.
  """
  require Logger

  alias SpotifyApi.Services.Spotify.Config

  @doc """
  Authenticates with the Spotify API using client credentials.
  """
  @spec authenticate() :: {:ok, String.t()} | {:error, String.t()}
  def authenticate() do
    config = Config.new()

    case HTTPoison.post(config.api_url <> "/api/token", config.body, config.headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, parse_token(body)}

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("Authentication failed with reason: #{inspect(reason)}")

        {:error, "Authentication failed with reason: #{reason}"}
    end
  end

  defp parse_token(body) do
    body
    |> Jason.decode!()
    |> Map.get("access_token")
  end
end
