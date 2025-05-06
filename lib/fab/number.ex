defmodule Fab.Number do
  @moduledoc """
  Functions for generating random numbers.
  """

  import Fab.Randomizer

  @integer_max 9_007_199_254_740_991

  @doc """
  Returns a random float.

  ## Options

  - `:min` - Lower bound of the generated float. Defaults to `0.0`.
  - `:max` - Upper bound of the generated float. Defaults to `1.0`.
  - `:precision` - Number of digits after the decimal point. Defaults to `1`.

  ## Examples

      iex> Fab.Number.float()
      0.2

      iex> Fab.Number.float(5.0)
      1.1

      iex> Fab.Number.float(min: 1.0, max: 2.0)
      1.2

      iex> Fab.Number.float(precision: 3)
      0.217
  """
  @spec float(number | keyword) :: float
  def float(opts \\ [])

  def float(max) when is_number(max) do
    float(max: max)
  end

  def float(opts) do
    min = Keyword.get(opts, :min, 0.0)
    max = Keyword.get(opts, :max, 1.0)
    precision = Keyword.get(opts, :precision, 1)

    real = uniform()

    Float.round(real * (max - min) + min, precision)
  end

  @doc """
  Returns a random integer.

  ## Options

  - `:min` - Lower bound of the generated integer. Defaults to `0`.
  - `:max` - Upper bound of the generated integer. Defaults to
    `#{@integer_max}`.

  ## Examples

      iex> Fab.Number.integer()
      3630114979716424

      iex> Fab.Number.integer(1000)
      340

      iex> Fab.Number.integer(min: 1, max: 1000)
      185
  """
  @spec integer(pos_integer | keyword) :: integer
  def integer(opts \\ [])

  def integer(max) when is_integer(max) do
    integer(max: max)
  end

  def integer(opts) do
    min = Keyword.get(opts, :min, 0)
    max = Keyword.get(opts, :max, @integer_max)

    random(min..max)
  end
end
