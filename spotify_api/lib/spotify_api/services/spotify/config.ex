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
      api_url: get_api_base_url(),
      headers: [
        {"Content-Type", "application/json"},
        {"Accept", "application/json"}
      ],
      body: %{}
    }
  end


  defp get_api_base_url() do
    System.get_env("SPOTIFY_API_BASE_URL")
  end
end
