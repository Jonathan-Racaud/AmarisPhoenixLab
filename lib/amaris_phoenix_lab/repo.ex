defmodule AmarisPhoenixLab.Repo do
  use Ecto.Repo,
    otp_app: :amaris_phoenix_lab,
    adapter: Ecto.Adapters.Postgres
end
