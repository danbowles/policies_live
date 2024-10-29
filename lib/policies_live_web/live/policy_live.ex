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

  def handle_info({:update, opts}, socket) do
    path = Routes.live_path(socket, __MODULE__, opts)
    {:noreply, push_patch(socket, to: path, replace: true)}
  end

  def assign_policies(socket) do
    socket
    |> assign(:policies, Policies.list_policies(%{}))
    |> assign(:sorting, %{sort_by: :insured_first_name, sort_dir: :asc})
  end
end
