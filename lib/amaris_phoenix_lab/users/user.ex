defmodule AmarisPhoenixLab.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  alias AmarisPhoenixLab.CMS.{Project, UserProject}

  schema "users" do
    field :role, :string, default: "user"
    many_to_many :projects, Project, join_through: UserProject, on_replace: :delete

    pow_user_fields()

    timestamps()
  end

  @spec changeset_role(Ecto.Schema.t() | Ecto.Changeset.t(), map()) :: Ecto.Changeset.t()
  def changeset_role(user_or_changeset, attrs) do
    user_or_changeset
    |> Ecto.Changeset.cast(attrs, [:role])
    |> Ecto.Changeset.validate_inclusion(:role, ~w(user admin))
  end
end
