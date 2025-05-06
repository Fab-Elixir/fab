defmodule Fab.LocalTest do
  use ExUnit.Case, async: true

  test "localize/3" do
    assert Fab.locale() == :en
    assert Fab.Locale.localize(Fab.Mock, :rando, []) == Fab.En.Mock.rando()

    :ok = Fab.set_locale(:es)

    assert Fab.locale() == :es
    assert Fab.Locale.localize(Fab.Mock, :rando, []) == Fab.Es.Mock.rando()
  end
end
