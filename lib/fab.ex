defmodule Fab do
  @moduledoc """
  Fab is an Elixir library for generating fake data.

  ## Localization

  Fab supports generating localized fake data. You can set the preferred locale
  using the `:locale` application configuration:

      config :fab, :locale, :es

  If the specified locale is not implemented, Fab falls back to the `:en`
  locale.
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
