defmodule PoliciesLiveWeb.PolicyLive do
  use PoliciesLiveWeb, :live_view
  alias PoliciesLive.Policies
  alias PoliciesLiveWeb.Forms.SortingForm
  alias PoliciesLiveWeb.Forms.FilterForm

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
    %{sorting: sorting, filter: filter} = socket.assigns

    params = %{} |> Map.merge(sorting) |> Map.merge(filter) |> Map.merge(opts)
    path = PoliciesLiveWeb.Router.Helpers.live_path(socket, __MODULE__, params)

    {:noreply, push_patch(socket, to: path, replace: true)}
  end

  def parse_params(socket, params) do
    with {:ok, sorting_opts} <- SortingForm.parse(params),
         {:ok, filter_opts} <- FilterForm.parse(params) do
      socket |> assign_sorting(sorting_opts) |> assign_filter(filter_opts)
    else
      _error -> socket |> assign_sorting() |> assign_filter()
    end
  end

  def assign_sorting(socket, overrides \\ %{}) do
    opts = Map.merge(SortingForm.default_values(), overrides)

    socket
    |> assign(:sorting, opts)
  end

  def assign_filter(socket, overrides \\ %{}) do
    socket
    |> assign(:filter, FilterForm.default_values(overrides))
  end

  def assign_policies(socket) do
    %{sorting: sorting, filter: filter} = socket.assigns

    params = %{} |> Map.merge(sorting) |> Map.merge(filter)

    socket
    |> assign(:policies, Policies.list_policies(params))
  end
end
