defmodule SpotifyApi.Modals.Album do
  import Ecto.Changeset
  use Ecto.Schema

  alias SpotifyApi.Modals.Artist

  @derive {Jason.Encoder, only: [:name, :spotify_id, :release_date]}
  schema "albums" do
    field :name, :string
    field :release_date, :string
    field :spotify_id, :string

    belongs_to :artist, Artist
    timestamps()
  end

  @required_fields [:name, :spotify_id]
  @optional_fields [:release_date]

  def changeset(album, attrs) do
    album
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:spotify_id)
  end
end
