defmodule RemoteBackend.Repo do
  use Ecto.Repo,
    otp_app: :remote_backend,
    adapter: Ecto.Adapters.Postgres
end
