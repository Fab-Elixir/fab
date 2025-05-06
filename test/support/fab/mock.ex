defmodule Fab.Mock do
  import Fab.Locale

  def rando do
    __MODULE__
    |> localize(:rando, [])
    |> Enum.random()
  end
end
