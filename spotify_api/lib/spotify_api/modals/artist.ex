defmodule SpotifyApi.Modals.Artist do
  use Ecto.Schema
  import Ecto.Changeset

  alias SpotifyApi.Modals.Album

  @derive {Jason.Encoder, only: [:name, :albums]}
  schema "artists" do
    field :name, :string
    field :spotify_id, :string

    has_many :albums, Album, on_delete: :delete_all, on_replace: :delete

    timestamps()
  end

  @required_fields [:name, :spotify_id]

  def changeset(artist, attrs) do
    artist
    |> cast(attrs, @required_fields)
    |> cast_assoc(:albums)
    |> validate_required(@required_fields)
    |> unique_constraint(:spotify_id)
  end
end
