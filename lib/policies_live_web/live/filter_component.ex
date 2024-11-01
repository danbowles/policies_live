defmodule PoliciesLiveWeb.PolicyLive.FilterComponent do
  alias PoliciesLiveWeb.Forms.FilterForm
  use PoliciesLiveWeb, :live_component

  def render(assigns) do
    ~H"""
    <div>
      <.form :let={f} for={@changeset} as={:filter} phx-submit="search" phx-target={@myself}>
        <div class="flex mb-4 gap-x-3">
          <div class="w-1/4">
            <.input field={f[:policy_number]} label="Policy Number" />
          </div>
          <div class="w-1/4">
            <.input field={f[:insured_first_name]} label="First Name" />
          </div>
          <div class="w-1/4">
            <.input field={f[:insured_last_name]} label="Last Name" />
          </div>
          <div class="w-1/5 flex">
            <.button class="mt-auto" type="submit">Search</.button>
          </div>
        </div>
      </.form>
    </div>
    """
  end

  def update(%{filter: filter}, socket) do
    {:ok, assign(socket, :changeset, FilterForm.change_values(filter))}
  end

  def handle_event("search", %{"filter" => filter}, socket) do
    case FilterForm.parse(filter) do
      {:ok, opts} ->
        send(self(), {:update, opts})
        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
