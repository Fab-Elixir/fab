defmodule Fab.TemplateTest do
  use ExUnit.Case, async: true

  test "render/1" do
    template =
      %Fab.Template{
        bindings: [
          b1: {__MODULE__, :b1, []},
          b2: {__MODULE__, :b2, []}
        ],
        source: "<%= b1 %> <%= b2 %>"
      }

    assert "Hello World" == Fab.Template.render(template)

    template =
      %Fab.Template{
        bindings: [
          b1: "Hello",
          b2: "World"
        ],
        source: "<%= b1 %> <%= b2 %>"
      }

    assert "Hello World" == Fab.Template.render(template)
  end

  def b1 do
    "Hello"
  end

  def b2 do
    "World"
  end
end
