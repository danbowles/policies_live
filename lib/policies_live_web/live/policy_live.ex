defmodule PoliciesLiveWeb.PolicyLive do
  use PoliciesLiveWeb, :live_view
  alias PoliciesLive.Policies

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(_params, _url, socket) do
    socket =
      socket
      |> assign_policies()

    {:noreply, socket}
  end

  def assign_policies(socket) do
    assign(socket, :policies, Policies.list_policies())
  end
end
