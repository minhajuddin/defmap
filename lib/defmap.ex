defmodule Defmap do
  @moduledoc File.read!(Path.join([__DIR__, "..", "README.md"]))

  defmacro __using__(opts) do
    quote do
      import Defmap, only: [compile: 1]
      compile unquote(opts)
    end
  end

  @doc false
  defmacro compile(opts) do

    # map is turned into its AST in the macro
    {_, _, map} = Keyword.fetch!(opts, :map)
    func_name = opts[:func_name] || :get

    catch_all = quote do
      def unquote(func_name)(_) do
        :error
      end
    end

    Enum.reduce(map, [catch_all], fn({key,value}, acc) ->
      fun = quote do
        def unquote(func_name)(unquote(key)) do
          {:ok, unquote(value)}
        end
      end
      [fun | acc]
    end)
  end
end
