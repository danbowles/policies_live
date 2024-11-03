defmodule PoliciesLiveWeb.Forms.PaginationForm do
  import Ecto.Changeset

  @fields %{
    page: :integer,
    page_size: :integer,
    total_count: :integer
  }

  @default_values %{
    page: 1,
    page_size: 20,
    total_count: 0
  }

  def parse(params, values \\ @default_values) do
    IO.puts("PaginationForm.parse")
    # IO.inspect(values)
    # IO.inspect(params)

    IO.inspect(
      {values, @fields}
      |> cast(params, Map.keys(@fields))
    )

    {values, @fields}
    |> cast(params, Map.keys(@fields))
    |> validate_number(:page, greater_than: 0)
    |> validate_number(:page_size, greater_than: 0)
    |> validate_number(:total_count, greater_than_or_equal_to: 0)
    |> apply_action(:insert)
  end

  # defp page_size_to_integer(changeset) do
  #   # IO.inspect(get_field(changeset, :page_size))
  #   case get_field(changeset, :page_size) do
  #     nil -> changeset
  #     page_size -> put_change(changeset, :page_size, String.to_integer(page_size))
  #   end
  # end

  def default_values(overrides \\ %{}) do
    Map.merge(@default_values, overrides)
  end
end
