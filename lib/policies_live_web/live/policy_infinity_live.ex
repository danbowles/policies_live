defmodule PoliciesLiveWeb.PolicyInfinityLive do
  use PoliciesLiveWeb, :live_view

  def mount(_params, _session, socket) do
    count = PoliciesLive.Policies.policy_count()

    socket =
      socket
      |> assign(offset: 0, limit: 25, count: count)
      |> load_policies()

    {:ok, socket, temporary_assigns: [policies: []]}
  end

  defp load_policies(socket) do
    %{offset: offset, limit: limit} = socket.assigns
    policies = PoliciesLive.Policies.list_policies_with_pagination(offset, limit)
    assign(socket, :policies, policies)
  end

  def handle_event("load-more", _params, socket) do
    %{offset: offset, limit: limit, count: count} = socket.assigns

    socket =
      if offset < count do
        socket
        |> assign(offset: offset + limit)
        |> load_policies()
      else
        socket
      end

    {:noreply, socket}
  end
end
