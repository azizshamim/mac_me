defmodule MacMe.V1.UserControllerTest do
  use MacMe.ConnCase

  alias MacMe.User

  @valid_attrs %{
    avatar_url: "some content",
    github_username: "some content",
    irc_username: "some content"
  }

  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end
end
