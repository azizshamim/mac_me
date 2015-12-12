defmodule MacMe.V1.UserView do
  use MacMe.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, MacMe.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, MacMe.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      irc_username: user.irc_username,
      github_username: user.github_username,
      avatar_url: user.avatar_url}
  end
end
