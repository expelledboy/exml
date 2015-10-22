defmodule Exml.Test do
  use ExUnit.Case

  test "simple xpath node" do
    xml = "<person ref=\"123\"><name title=\"\">anthony</name></person>"
    assert "anthony" = Exml.parse(xml) |> Exml.get "//person/name"
    assert "123" = Exml.parse(xml) |> Exml.get "//person/@ref"
    assert nil = Exml.parse(xml) |> Exml.get "//no/path"
    assert "" = Exml.parse(xml) |> Exml.get "//name/@title"
    xml = "<list><item>one</item><item>two</item></list>"
    assert ["one","two"] = Exml.parse(xml) |> Exml.get "//item"
  end
end
