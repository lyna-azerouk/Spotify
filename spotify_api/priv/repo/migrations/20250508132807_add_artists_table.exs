defmodule SpotifyApi.Repo.Migrations.AddArtistsTable do
  use Ecto.Migration

  def change do
    create table(:artists) do
      add :name, :string
      add :spotify_id, :string

      timestamps()
    end

    create unique_index(:artists, [:spotify_id])
  end
end
