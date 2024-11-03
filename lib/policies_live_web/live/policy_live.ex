defmodule PoliciesLiveWeb.PolicyLive do
  use PoliciesLiveWeb, :live_view
  alias PoliciesLive.Policies
  alias PoliciesLiveWeb.Forms.SortingForm
  alias PoliciesLiveWeb.Forms.FilterForm
  alias PoliciesLiveWeb.Forms.PaginationForm

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
    params = merge_sanitized_params(socket, opts)

    path = PoliciesLiveWeb.Router.Helpers.live_path(socket, __MODULE__, params)

    {:noreply, push_patch(socket, to: path, replace: true)}
  end

  def parse_params(socket, params) do
    with {:ok, sorting_opts} <- SortingForm.parse(params),
         {:ok, pagination_opts} <- PaginationForm.parse(params),
         {:ok, filter_opts} <- FilterForm.parse(params) do
      socket
      |> assign_sorting(sorting_opts)
      |> assign_filter(filter_opts)
      |> assign_pagination(pagination_opts)
    else
      _error -> socket |> assign_sorting() |> assign_filter() |> assign_pagination()
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

  defp assign_pagination(socket, overrides \\ %{}) do
    socket
    |> assign(:pagination, PaginationForm.default_values(overrides))
  end

  def assign_policies(socket) do
    params = merge_sanitized_params(socket)
    %{policies: policies, count: count} = Policies.list_policies_with_count(params)

    socket
    |> assign(:policies, policies)
    |> assign_total_count(count)
  end

  defp merge_sanitized_params(socket, overrides \\ %{}) do
    %{sorting: sorting, filter: filter, pagination: pagination} = socket.assigns
    overrides = maybe_reset_pagination(overrides)

    %{}
    |> Map.merge(sorting)
    |> Map.merge(filter)
    |> Map.merge(pagination)
    |> Map.merge(overrides)
    |> Map.drop([:total_count])
    |> Enum.reject(fn {_k, v} -> is_nil(v) end)
    |> Map.new()
  end

  defp assign_total_count(socket, total_count) do
    update(socket, :pagination, fn pagination -> %{pagination | total_count: total_count} end)
  end

  defp maybe_reset_pagination(overrides) do
    if FilterForm.contains_filter_values?(overrides) do
      Map.put(overrides, :page, 1)
    else
      overrides
    end
  end
end
