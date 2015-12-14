defmodule MacMe.ChangesetView do
  @moduledoc """
  Default rendering of viewing Changeset Errors
  """
  use MacMe.Web, :view

  def render("error.json", %{changeset: changeset}) do
    # When encoded, the changeset returns its errors
    # as a JSON object. So we just pass it forward.
    %{errors: changeset}
  end
end
