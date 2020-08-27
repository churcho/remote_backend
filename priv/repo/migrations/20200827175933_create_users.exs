defmodule RemoteBackend.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:points, :integer, null: false)
      timestamps(type: :utc_datetime_usec)
    end
  end
end
