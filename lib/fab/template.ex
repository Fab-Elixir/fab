defmodule Fab.Template do
  @moduledoc """
  Dynamically generate formatted text using EEx templates.

  `Fab.Template` defines EEx templates with bindings resolved at runtime via
  `{module, function, args}` tuples or static string values. Useful when fake
  data must match a specific format, such as localized output in locale
  modules.
  """

  @type binding_t ::
          {atom, mfa | String.t()}

  @type t ::
          %__MODULE__{
            bindings: [binding_t],
            source: String.t()
          }

  @enforce_keys [:bindings, :source]

  defstruct [:bindings, :source]

  @doc """
  Renders the template by evaluating its bindings and applying them to the EEx
  source.

  Each binding must be a `{module, function, args}` tuple or a static string.
  If the binding is an MFA it will be invoked at render time. If the binding is
  a string it will be used as-is. The results are passed as the template
  context.

  Returns the rendered string.
  """
  @doc since: "1.2.0"
  @spec render(t) :: String.t()
  def render(template) do
    bindings =
      Enum.map(template.bindings, fn
        {key, {m, f, a}} ->
          {key, apply(m, f, a)}

        {key, value} ->
          {key, value}
      end)

    EEx.eval_string(template.source, bindings)
  end
end
