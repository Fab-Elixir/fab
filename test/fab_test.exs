defmodule FabTest do
  use ExUnit.Case, async: true

  setup tags do
    seed =
      tags[:test]
      |> to_string()
      |> String.replace(~r/\(\d+\)/, "")
      |> String.trim()
      |> :binary.decode_unsigned()

    Application.put_env(:fab, :seed, seed)

    :ok
  end

  doctest Fab.Number
  doctest Fab.String
end
