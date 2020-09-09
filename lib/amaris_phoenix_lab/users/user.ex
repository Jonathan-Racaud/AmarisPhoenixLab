defmodule AmarisPhoenixLab.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    pow_user_fields()
    field :role_id, :id

    timestamps()
  end
end
