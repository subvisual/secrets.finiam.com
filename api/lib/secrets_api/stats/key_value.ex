defmodule SecretsApi.Stats.KeyValue do
  @moduledoc """
  This module is an Ecto model that
  just stores key value records.
  """

  use Ecto.Schema
  import Ecto.Changeset

  defmodule KeyEnum do
    @moduledoc """
    This is an EctoEnum module that contains
    the different allowed keys for the key value
    store.
    """
    use EctoEnum,
      secrets_counter: "secrets_counter"
  end

  schema "analytics_key_value" do
    field(:key, KeyEnum)
    field(:value, :string)

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:key, :value])
    |> validate_required([:key, :value])
    |> unique_constraint([:key])
  end
end
