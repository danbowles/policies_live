defmodule PoliciesLiveWeb.Forms.SortingFormTests do
  use PoliciesLive.DataCase, async: true

  alias PoliciesLiveWeb.Forms.SortingForm

  @default_params %{
    "sort_by" => "insured_first_name",
    "sort_dir" => "asc"
  }

  describe "parse/1" do
    test "should parse all param fields correctly" do
      {:ok, params} = SortingForm.parse(@default_params)
      assert params.sort_by == :insured_first_name
      assert params.sort_dir == :asc
    end

    test "should return rest of params as default values" do
      {:ok, params} = SortingForm.parse(%{"sort_by" => "insured_first_name"})
      assert params.sort_by == :insured_first_name
      assert params.sort_dir == :asc
    end

    test "should validate fields" do
      assert {:error, _} = SortingForm.parse(%{"sort_by" => "invalid"})
    end
  end
end
