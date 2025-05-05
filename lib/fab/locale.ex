defmodule Fab.Locale do
  @moduledoc """
  Provides dynamic function dispatch based on the current locale. 
  """

  @doc """
  Dynamically resolves and invokes a localized implementation of a given
  function.

  Constructs a module path based on the current locale by inserting the locale
  between the root and the provider module segments. Then attempts to load and
  invoke the specified function from this localized module. If the localized
  module or function is unavailable, falls back to using the English version of
  the module.

  ## Example

      iex> Fab.set_locale(:es)
      ...> Fab.Locale.localize(Fab.MyMod, :rando, [])

  This would resolve to:

    - `Fab.Es.MyMod.rando/0`
    - or `Fab.En.MyMod.rando/0` if the localized implementation does not exist
  """
  @spec localize(module, atom, list) :: any
  def localize(mod, fun, args) do
    locale =
      Fab.locale()
      |> to_string()
      |> Macro.camelize()
      |> String.replace("_", "")

    split_mod = Module.split(mod)

    root = List.first(split_mod)
    provider = List.last(split_mod)

    locale_mod = Module.concat([root, locale, provider])

    provider_mod =
      with {:module, _} <- Code.ensure_loaded(locale_mod),
           true <- function_exported?(locale_mod, fun, length(args)) do
        locale_mod
      else
        _ ->
          Module.concat([root, En, mod])
      end

    apply(provider_mod, fun, args)
  end
end
