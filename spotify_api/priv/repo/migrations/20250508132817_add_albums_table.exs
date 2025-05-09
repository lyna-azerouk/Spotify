defmodule SpotifyApi.Repo.Migrations.AddAlbumsTable do
  use Ecto.Migration

  def change do
    create table(:albums) do
      add :name, :string
      add :release_date, :string
      add :spotify_id, :string
      add :artist_id, references(:artists, on_delete: :nothing)

      timestamps()
    end
  end
end
