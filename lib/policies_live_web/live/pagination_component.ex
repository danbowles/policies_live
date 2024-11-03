defmodule PoliciesLiveWeb.PolicyLive.PaginationComponent do
  use PoliciesLiveWeb, :live_component

  alias PoliciesLiveWeb.Forms.PaginationForm

  def render(assigns) do
    ~H"""
    <div>
      <div class="flex">
        <%= for {page_number, current_page?, first?, last?} <- pages(@pagination) do %>
          <a
            href="#"
            class={"pagination-button rounded-lg px-3 py-1 border border-gray-300 #{if current_page?, do: "active"}"}
            phx-click="show_page"
            phx-value-page={page_number}
            phx-target={@myself}
          >
            <%!-- Todo: Yikes... --%>
            <%= if first? do %>
              First
            <% end %>
            <%= if last? do %>
              Last
            <% end %>
            <%= unless first? or last? do %>
              <%= page_number %>
            <% end %>
          </a>
        <% end %>
      </div>
      <.form :let={f} for={@pagination} phx-target={@myself}>
        <div class="flex mb-4 gap-x-3">
          <div class="w-1/4">
            <.input
              phx-change="set_page_size"
              field={f[:page_size]}
              type="select"
              options={[10, 20, 50, 100]}
              value={@pagination.page_size}
            />
          </div>
        </div>
      </.form>
    </div>
    """
  end

  def pages(%{page_size: page_size, page: current_page, total_count: total_count}) do
    page_count = ceil(total_count / page_size)

    page_range_min = max(2, current_page - 3)
    page_range_max = min(page_count - 1, current_page + 3)

    # for page <- 1..page_count//1 do
    pages =
      for page <- page_range_min..page_range_max do
        current_page? = page == current_page
        first? = page == 1
        last? = page == page_count

        {page, current_page?, first?, last?}
      end

    pages =
      [
        {1, current_page == 1, true, false}
      ] ++
        pages ++
        [
          {page_count, current_page == page_count, false, true}
        ]

    pages
  end

  def handle_event("show_page", params, socket) do
    params |> parse_params(socket)
  end

  def handle_event("set_page_size", %{"page_size" => params}, socket) do
    %{"page_size" => params} |> parse_params(socket)
  end

  # todo set page size event

  def parse_params(params, socket) do
    %{pagination: pagination} = socket.assigns

    case PaginationForm.parse(params, pagination) do
      {:ok, opts} ->
        send(self(), {:update, opts})
        {:noreply, socket}

      {:error, _changeset} ->
        {:noreply, socket}
    end
  end
end
