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
end
