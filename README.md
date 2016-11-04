# defmap

Defmap is a utility which allows you to embed a map into a module for faster/easier
lookups.

## Usage

```elixir
defmodule HttpStatusMessages do
  use Defmap, [ map: %{
                       400 => "Bad Request",
                       401 => "Unauthorized",
                       403 => "Forbidden",
                     }]
end

IO.inspect HttpStatusMessages.get(401) # => {:ok, "Unauthorized"}
IO.inspect HttpStatusMessages.get(3)   # => :error
```

## Installation

The package can be installed as:

  1. Add `defmap` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:defmap, "~> 0.1.0"}]
    end
    ```

  2. Ensure `defmap` is started before your application:

    ```elixir
    def application do
      [applications: [:defmap]]
    end
    ```
