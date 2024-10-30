defmodule PoliciesLiveWeb.PolicyLive do
  use PoliciesLiveWeb, :live_view
  alias PoliciesLive.Policies
  alias PoliciesLiveWeb.Forms.SortingForm

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(params, _url, socket) do
    socket =
      socket
      |> parse_params(params)
      |> assign_policies()

    {:noreply, socket}
  end

  def handle_info({:update, opts}, socket) do
    path = PoliciesLiveWeb.Router.Helpers.live_path(socket, __MODULE__, opts)
    {:noreply, push_patch(socket, to: path, replace: true)}
  end

  def parse_params(socket, params) do
    with {:ok, sorting_opts} <- SortingForm.parse(params) do
      assign_sorting(socket, sorting_opts)
    end
  end

  def assign_sorting(socket, overrides \\ %{}) do
    opts = Map.merge(SortingForm.default_values(), overrides)

    socket
    |> assign(:sorting, opts)
  end

  def assign_policies(socket) do
    %{sorting: sorting} = socket.assigns

    socket
    |> assign(:policies, Policies.list_policies(sorting))
  end
end
