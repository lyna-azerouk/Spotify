defmodule SpotifyApi.Modals.Artist do
  use Ecto.Schema
  import Ecto.Changeset

  schema "artists" do
    field :name, :string
    field :spotify_id, :string

    timestamps()
  end

  def changeset(artist, attrs) do
    artist
    |> cast(attrs, [:name, :spotify_id])
    |> validate_required([:name, :spotify_id])
  end
end
