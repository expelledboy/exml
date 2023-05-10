defmodule Exml.Test do
  use ExUnit.Case

  test "xpath" do
    xml = "<person ref=\"123\"><name title=\"\">anthony</name></person>"
    assert "anthony" == Exml.parse(xml) |> Exml.get("//person/name")
    assert "123" == Exml.parse(xml) |> Exml.get("//person/@ref")
    assert nil == Exml.parse(xml) |> Exml.get("//no/path")
    assert "" == Exml.parse(xml) |> Exml.get("//name/@title")
    xml = "<list><item>one</item><item>two</item></list>"
    assert ["one", "two"] == Exml.parse(xml) |> Exml.get("//item")
  end

  test "xml object" do
    assert 2 == Exml.parse("<ul><li>item</li><li>item</li></ul>") |> Exml.get("count(//li)")
    assert "item" == Exml.parse("<item />") |> Exml.get("name(/*)")
  end

  test "cant find xpath" do
    xml = "<data></data>"
    assert nil == Exml.parse(xml) |> Exml.get("//key")
  end

  test "invalid xml" do
    assert {:fatal, {:unexpected_end, _, {:line, 1}, {:col, 25}}} =
             catch_exit(Exml.parse("<data><key>value</key>"))
  end
end
