defmodule SpotifyApi.Repo.Migrations.AddAlbumsTable do
  use Ecto.Migration

  def change do
    create table(:albums) do
      add :name, :string
      add :release_date, :date
      add :spotify_id, :string
      add :artist_id, references(:artists, on_delete: :nothing), null: false

      timestamps()
    end

    create unique_index(:albums, [:spotify_id])
    create index(:albums, [:artist_id])
  end
end
