defmodule Fab do
  @moduledoc """
  Fab is a lightweight Elixir library for generating fake data.

  ## Philosophy

  Fab is built with a simple goal: **keep the core small and focused**. Instead
  of bundling massive datasets and every conceivable fake data generator, Fab
  provides a minimal, fast, and composable foundation for generating common
  data.

  Need more? Use a use-case specific Fab library or create your own.

  ### Why Not Include More?

  Many faker libraries become bloated over time. Fab avoids that by:

  - Keeping the core library focused and fast
  - Letting users define their own generators
  - Supporting optional extensions via external packages

  ## Usage

  See the individual generator modules for usage examples.

  - `Fab.DateTime`
  - `Fab.Number`
  - `Fab.String`

  ### Localization

  Fab supports generating localized fake data. You can set your preferred locale
  using the `:locale` application configuration:

      config :fab, :locale, :es

  If the specified locale is not implemented, Fab falls back to the `:en`
  locale by default.

  ### Deterministic Values

  If you need the values returned by Fab to be deterministic specify a `:seed`
  value:

      config :fab, :seed, 0

  `Fab.Randomizer` functions will use this seed when picking random values.
  """

  @doc """
  Returns the current locale used for generating fake data.
  """
  @spec locale :: atom
  def locale do
    default = Application.get_env(:fab, :locale, :en)

    Process.get(:__fab_locale__, default)
  end

  @doc """
  Sets the global locale for generating fake data.

  Use this when you want Fab to always use the specified locale.
  """
  @spec put_locale(atom) :: :ok
  def put_locale(locale) do
    Application.put_env(:fab, :locale, locale)

    :ok
  end

  @doc """
  Sets the locale for generating fake data in the current process.

  This is useful when you need a specific locale for a test or a temporary
  context.
  """
  @spec set_locale(atom) :: :ok
  def set_locale(locale) do
    Process.put(:__fab_locale__, locale)

    :ok
  end
end
