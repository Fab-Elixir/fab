defmodule FabTest do
  use ExUnit.Case

  setup tags do
    seed = :binary.decode_unsigned(to_string(tags[:test]))

    Application.put_env(:fab, :consistent, true)
    Application.put_env(:fab, :seed, seed)

    :ok
  end

  doctest Fab.Number
end
