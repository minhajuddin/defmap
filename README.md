# defmap

[![Travis](https://img.shields.io/travis/minhajuddin/defmap.svg?style=flat-square)](https://travis-ci.org/minhajuddin/defmap)
[![Hex.pm](https://img.shields.io/hexpm/v/defmap.svg?style=flat-square)](https://hex.pm/packages/defmap)
[![Hex.pm](https://img.shields.io/hexpm/dt/defmap.svg?style=flat-square)](https://hex.pm/packages/defmap)

Defmap is a utility which allows you to embed a map into a module for faster/easier
lookups. A lot of times you may want to have lookup tables in your app. e.g. when
you need to map error codes to messages. Using Defmap, you directly embed the lookup
map/table into your module, this improves the performance and decreases the memory used.

## Example Usage

### Simple lookup which adds a HttpStatusMessages.get method
```elixir
defmodule HttpStatusMessages do
  use Defmap, map: %{
                       400 => "Bad Request",
                       401 => "Unauthorized",
                       403 => "Forbidden",
                     }
end

IO.inspect HttpStatusMessages.get(401) # => {:ok, "Unauthorized"}
IO.inspect HttpStatusMessages.get(3)   # => :error
```

### Lookup with custom function name
```elixir
defmodule HttpStatusMessages do
  use Defmap, func_name: :get_message, map: %{
                       400 => "Bad Request",
                       401 => "Unauthorized",
                       403 => "Forbidden",
                     }
end

IO.inspect HttpStatusMessages.get_message(401) # => {:ok, "Unauthorized"}
IO.inspect HttpStatusMessages.get_message(3)   # => :error
```

### Multiple lookups
```elixir
defmodule HttpStatusMessages do
  use Defmap, func_name: :get_message, map: %{
                       400 => "Bad Request",
                       401 => "Unauthorized",
                       403 => "Forbidden",
                     }

  use Defmap, func_name: :get_detailed_info, map: %{
                       400 => "Bad Request, happens when your input is invalid",
                       401 => "Unauthorized, happens when you don't have enough privileges",
                     }
end

IO.inspect HttpStatusMessages.get_message(401) # => {:ok, "Unauthorized"}
IO.inspect HttpStatusMessages.get_message(3)   # => :error

IO.inspect HttpStatusMessages.get_detailed_info(401) # => {:ok,  "Bad Request, happens when your input is invalid"}
IO.inspect HttpStatusMessages.get_detailed_info(3)   # => :error
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
