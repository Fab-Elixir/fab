defmodule FabTest do
  use ExUnit.Case

  setup do
    Application.put_env(:fab, :consistent, true)
    :ok
  end

  doctest Fab.Number
end
