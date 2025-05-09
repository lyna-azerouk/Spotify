defmodule SpotifyApi.Services.Spotify.Config do
  @doc """
  Configuration for the Spotify API client.
  """

  @type t :: %__MODULE__{}

  defstruct api_url: nil,
            headers: nil,
            body: nil

  def new() do
    %__MODULE__{
      api_url: get_api_account_url(),
      headers: [
        {"Content-Type", "application/x-www-form-urlencoded"},
        {"Authorization", "Basic #{Base.encode64("#{get_client_id()}:#{get_client_secret()}")}"}
      ],
      body: URI.encode_query(%{"grant_type" => "client_credentials"})
    }
  end

  def new(bearer_token) do
    %__MODULE__{
      api_url: get_api_base_url(),
      headers: [
        {"Authorization", "Bearer #{bearer_token}"}
      ],
      body: %{}
    }
  end

  defp get_api_base_url(), do: System.get_env("SPOTIFY_API_BASE_URL")

  defp get_api_account_url(), do: System.get_env("SPOTIFY_API_BASE_URL")

  defp get_client_id(), do: System.get_env("SPOTIFY_CLIENT_ID")
  defp get_client_secret(), do: System.get_env("SPOTIFY_CLIENT_SECRET")
end
