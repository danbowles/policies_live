defmodule PoliciesLive.Policies do
  @moduledoc """
  Policies jcontext
  """

  alias PoliciesLive.Repo

  def list_policies do
    PoliciesLive.Policies.Policy
    |> Repo.all()
  end
end
