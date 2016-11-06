defmodule DefmapTest do
  use ExUnit.Case
  doctest Defmap

  describe "#get" do

    defmodule Rating do
      use Defmap, map: %{:awesome => "This is awesome"}
    end

    test "should return a value when key is present" do
      assert {:ok, "This is awesome"} = Rating.get(:awesome)
    end

    test "should return error when key is not present" do
      assert :error = Rating.get(33)
    end
  end

  describe "custom accessor" do
    defmodule Statuses do
      use Defmap, map: %{1 => "init", 2 => "started", 3 => "finished"},
      func_name: :get_status
    end

    test "should return a value when key is present" do
      assert {:ok, "init"} = Statuses.get_status(1)
      assert {:ok, "finished"} = Statuses.get_status(3)
    end

    test "should return error when key is not present" do
      assert :error = Statuses.get_status(33)
    end
  end

  describe "#get from file" do
    defmodule HttpStatuses do
        use Defmap, map: (File.stream!(Path.expand(Path.join(__DIR__, "./http_statuses.csv")))
                          |> CSV.decode
                          |> Enum.reject(& length(&1) != 2)
                          |> Enum.map(fn [k, v] -> {String.to_integer(k), String.strip(v)} end)
                          |> Enum.into(%{})),
      func_name: :get_status
    end

    test "should return a value when key is present" do
      assert {:ok, "Unauthorized"} = HttpStatuses.get_status(401)
      assert {:ok, "Forbidden"} = HttpStatuses.get_status(403)
    end

    test "should return error when key is not present" do
      assert :error = HttpStatuses.get_status(33)
    end
  end
end
