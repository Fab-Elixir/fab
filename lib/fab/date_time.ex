defmodule Fab.DateTime do
  @moduledoc """
  Functions for generating random `DateTime`'s.
  """

  @type days_t ::
          {:days, pos_integer}

  @type from_t ::
          {:from, DateTime.t()}

  @type ref_date_t ::
          {:ref_date, DateTime.t()}

  @type to_t ::
          {:to, DateTime.t()}

  @type unit_t ::
          {:unit, :microsecond | :millisecond | :native | :second}

  @type years_t ::
          {:years, pos_integer}

  @seconds_in_day 86400

  @seconds_in_year 31_556_926

  @doc """
  Generates a random date that can be in the past or future.

  ## Options

  - `:ref_date` - `DateTime` used as the reference point for the newly generated date. Defaults to `DateTime.utc_now/1`.
  - `:unit` - Time unit used for the generated date. Can be `:microsecond`, `:millisecond`, `:native` or `:second`. Defaults to `:native`.

  ## Examples

      iex> Fab.DateTime.anytime()
      ~U[1523-04-23 21:41:18.532309Z]

      iex> Fab.DateTime.anytime(unit: :second)
      ~U[1965-10-18 11:26:15Z]
  """
  @doc since: "1.0.0"
  @spec anytime([ref_date_t | unit_t]) :: DateTime.t()
  def anytime(opts \\ []) do
    now = now(opts)

    from = DateTime.add(now, -1000 * @seconds_in_year)
    to = DateTime.add(now, 1000 * @seconds_in_year)

    opts
    |> Keyword.put(:from, from)
    |> Keyword.put(:to, to)
    |> between()
  end

  @doc """
  Generates a random date between two dates.

  ## Options

  - `:from` - `DateTime` used as the early date boundary
  - `:to` - `DateTime` used as the late date boundary
  - `:unit` - Time unit used for the generated date. Can be `:microsecond`, `:millisecond`, `:native` or `:second`. Defaults to `:native`.

  ## Examples

      iex> Fab.DateTime.between(from: ~U[2025-05-04 18:21:38Z], to: ~U[2025-05-05 21:38:40Z])
      ~U[2025-05-05 21:38:28.112142Z]

      iex> Fab.DateTime.between(from: ~U[2025-05-05 01:57:58Z], to: ~U[2025-05-06 10:34:09Z], unit: :second)
      ~U[2025-05-05 19:09:21Z]
  """
  @doc since: "1.0.0"
  @spec between([from_t | to_t | unit_t]) :: DateTime.t()
  def between(opts) do
    unit = unit(opts)

    from =
      opts
      |> Keyword.fetch!(:from)
      |> DateTime.to_unix(unit)

    to =
      opts
      |> Keyword.fetch!(:to)
      |> DateTime.to_unix(unit)

    from..to
    |> Enum.random()
    |> DateTime.from_unix!(unit)
  end

  @doc """
  Generates a random date years in the future.

  ## Options

  - `:ref_date` - `DateTime` used as the reference point for the newly generated date. Defaults to `DateTime.utc_now/1`.
  - `:unit` - Time unit used for the generated date. Can be `:microsecond`, `:millisecond`, `:native` or `:second`. Defaults to `:native`.
  - `:years` - Number of years the date may be in the future. Defaults to `1`.


  ## Examples

      iex> Fab.DateTime.future()
      ~U[2026-04-07 00:06:12.857101Z]

      iex> Fab.DateTime.future(years: 10)
      ~U[2028-09-19 10:23:55.939960Z]

      iex> Fab.DateTime.future(unit: :second)
      ~U[2026-03-24 06:13:08Z]
  """
  @doc since: "1.0.0"
  @spec future([ref_date_t | unit_t | years_t]) :: DateTime.t()
  def future(opts \\ []) do
    now = now(opts)
    years = Keyword.get(opts, :years, 1)

    to = DateTime.add(now, years * @seconds_in_year)

    opts
    |> Keyword.put(:from, now)
    |> Keyword.put(:to, to)
    |> between()
  end

  @doc """
  Generates a random date years in the past.

  ## Options

  - `:ref_date` - `DateTime` used as the reference point for the newly generated date. Defaults to `DateTime.utc_now/1`.
  - `:unit` - Time unit used for the generated date. Can be `:microsecond`, `:millisecond`, `:native` or `:second`. Defaults to `:native`.
  - `:years` - Number of years the date may be in the past. Defaults to `1`.


  ## Examples

      iex> Fab.DateTime.past()
      ~U[2025-01-24 16:01:23.564206Z]

      iex> Fab.DateTime.past(years: 10)
      ~U[2023-04-24 03:50:54.545857Z]

      iex> Fab.DateTime.past(unit: :second)
      ~U[2024-07-30 14:33:43Z]
  """
  @doc since: "1.0.0"
  @spec past([ref_date_t | unit_t | years_t]) :: DateTime.t()
  def past(opts \\ []) do
    years = Keyword.get(opts, :years, 1)
    now = now(opts)

    from = DateTime.add(now, -years * @seconds_in_year)

    opts
    |> Keyword.put(:from, from)
    |> Keyword.put(:to, now)
    |> between()
  end

  @doc """
  Generates a random date days in the past.

  ## Options

  - `:days` - Number of days the date may be in the past. Defaults to `1`.
  - `:ref_date` - `DateTime` used as the reference point for the newly generated date. Defaults to `DateTime.utc_now/1`.
  - `:unit` - Time unit used for the generated date. Can be `:microsecond`, `:millisecond`, `:native` or `:second`. Defaults to `:native`.

  ## Examples

      iex> Fab.DateTime.recent()
      ~U[2025-05-05 04:53:03.098150Z]

      iex> Fab.DateTime.recent(days: 10)
      ~U[2025-05-03 21:37:48.405103Z]

      iex> Fab.DateTime.recent(unit: :second)
      ~U[2025-05-05 16:44:47Z]
  """
  @doc since: "1.0.0"
  @spec recent([days_t | ref_date_t | unit_t]) :: DateTime.t()
  def recent(opts \\ []) do
    days = Keyword.get(opts, :days, 1)
    now = now(opts)

    from = DateTime.add(now, -days * @seconds_in_day)

    opts
    |> Keyword.put(:from, from)
    |> Keyword.put(:to, now)
    |> between()
  end

  @doc """
  Generates a random date days in the future.

  ## Options

  - `:days` - Number of days the date may be in the future. Defaults to `1`.
  - `:ref_date` - `DateTime` used as the reference point for the newly generated date. Defaults to `DateTime.utc_now/1`.
  - `:unit` - Time unit used for the generated date. Can be `:microsecond`, `:millisecond`, `:native` or `:second`. Defaults to `:native`.

  ## Examples

      iex> Fab.DateTime.soon()
      ~U[2025-05-05 19:38:07.213655Z]

      iex> Fab.DateTime.soon(days: 10)
      ~U[2025-05-12 08:56:42.439410Z]

      iex> Fab.DateTime.soon(unit: :second)
      ~U[2025-05-06 11:10:33Z]
  """
  @doc since: "1.0.0"
  @spec soon([days_t | ref_date_t | unit_t]) :: DateTime.t()
  def soon(opts \\ []) do
    days = Keyword.get(opts, :days, 1)
    now = now(opts)

    to = DateTime.add(now, days * @seconds_in_day)

    opts
    |> Keyword.put(:from, now)
    |> Keyword.put(:to, to)
    |> between()
  end

  @spec unit(keyword) :: atom
  defp unit(opts) do
    Keyword.get(opts, :unit, :native)
  end

  @spec now(keyword) :: DateTime.t()
  defp now(opts) do
    unit = unit(opts)

    # DateTime.utc_now/1 does not support passing a unit in Elixir 1.14.
    # Convert to/from unix to support full range of time units because
    # DateTime.truncate/2 does not support the :native unit.
    # TODO Use DateTime.utc_now/1 only when dropping Elixir 1.14.
    now =
      DateTime.utc_now()
      |> DateTime.to_unix(unit)
      |> DateTime.from_unix!(unit)

    Keyword.get(opts, :ref_date, now)
  end
end
