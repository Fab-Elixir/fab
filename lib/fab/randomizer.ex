defmodule Fab.Randomizer do
  @moduledoc """
  Functions for choosing or generating random values.

  The functions in this module are primarily used when implementing a generator
  module.
  """

  @spec random(Enum.t()) :: any
  def random(enumerable) do
    seed()
    Enum.random(enumerable)
  end

  @spec uniform :: float
  def uniform do
    seed()
    :rand.uniform()
  end

  @spec seed :: :ok
  defp seed do
    seed = Application.get_env(:fab, :seed)

    if seed do
      seed = Process.get(:__fab_seed__, seed)

      :rand.seed(:exsss, seed)

      Process.put(:__fab_seed__, seed + 1)
    end

    :ok
  end
end
