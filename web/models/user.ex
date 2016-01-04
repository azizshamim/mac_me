defmodule MacMe.User do
  @moduledoc """
  This module defines the model for a User, as it is stored
  in our database. Leverages Ecto in order to validate and store
  data.
  """
  use MacMe.Web, :model

  @default_avatar "https://avatars1.githubusercontent.com/u/532584"

  schema "users" do
    field :irc_username, :string
    field :github_username, :string
    field :avatar_url, :string, default: @default_avatar

    has_many :devices, MacMe.Device

    timestamps
  end

  @required_fields ~w(irc_username)
  @optional_fields ~w(github_username avatar_url)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_url(:avatar_url)
  end

  defp validate_url(changeset, field, options \\ []) do
    validate_change changeset, field, fn _, url ->
      case url |> String.to_char_list |> :http_uri.parse do
        {:ok, _} ->
          []
        {:error, msg} ->
          [{field, options[:message] || "invalid url: #{inspect msg}"}]
      end
    end
  end
end

defmodule MacMe.UserActions do
  import Ecto.Query
  alias MacMe.User
  alias MacMe.Repo

  def query_by_irc_username(irc_username) do
    query = from r in User,
    where: r.irc_username == ^irc_username,
    select: r
    Repo.all(query)
    |> Repo.preload([:devices])
    |> List.first
  end

  def register_new_user(user_params) do
    changeset = User.changeset(%User{}, user_params)
    Repo.insert(changeset)
  end

end
