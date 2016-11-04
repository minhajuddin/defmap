defmodule Defmap do
  @moduledoc File.read!(Path.join([__DIR__, "..", "README.md"]))
  defmacro __using__(opts) do
    map = Keyword.fetch! opts, :map
    quote do
      import MapCompiler, only: [compile: 1]
      compile unquote(map)
    end
  end

  defmacro compile({_, _, map}) do
    catch_all = quote do
      def get(_) do
        :error
      end
    end

    Enum.reduce(map, [catch_all], fn({key,value}, acc) ->
      fun = quote do
        def get(unquote(key)) do
          {:ok, unquote(value)}
        end
      end
      [fun | acc]
    end)
  end
end
