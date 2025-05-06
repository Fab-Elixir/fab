defmodule FabTest do
  use ExUnit.Case

  setup do
    :rand.seed(:exsss, {0, 0, 0})
    :ok
  end

  doctest Fab.Number
end
