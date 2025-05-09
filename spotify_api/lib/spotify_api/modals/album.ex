defmodule SpotifyApi.Modals.Album do
  import Ecto.Changeset
  use Ecto.Schema

  schema "albums" do
    field :name, :string
    field :release_date, :string
    field :spotify_id, :string

    belongs_to :artist, SpotifyApi.Modals.Artist
    timestamps()
  end

  @required_fields [:name, :release_date, :spotify_id]
  @optional_fields []

  def changeset(album, attrs) do
    album
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
