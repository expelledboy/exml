defmodule Exml.Test do
  use ExUnit.Case

  test "simple xpath node" do
    xml = "<person ref=\"123\"><name>anthony</name></person>"
    assert "anthony" = Exml.parse(xml) |> Exml.get "//person/name"
    assert "123" = Exml.parse(xml) |> Exml.get "//person/@ref"
  end
end
