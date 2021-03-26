defmodule Exml do
  require Record
  
  ~w(xmlElement xmlAttribute xmlText xmlObj)a
  |> Enum.map(&Record.defrecord(&1, Record.extract(&1, from_lib: "xmerl/include/xmerl.hrl")))
  
  def parse(xml_string, options \\ [quiet: true]) when is_binary(xml_string) do
    {doc, []} =
      xml_string
      |> :binary.bin_to_list()
      |> :xmerl_scan.string(options)

    doc
  end

  def get(node, path) do
    xpath(node, path) |> text
  end

  defp xpath(nil, _), do: nil

  defp xpath(node, path) do
    :xmerl_xpath.string(to_charlist(path), node)
  end

  defp text([]), do: nil
  defp text([item]), do: text(item)
  defp text(xmlElement(content: content)), do: text(content)
  defp text(xmlAttribute(value: value)), do: List.to_string(value)
  defp text(xmlText(value: value)), do: List.to_string(value)

  defp text(list) when is_list(list) do
    cond do
      Enum.all?(list, &parsable/1) -> Enum.map(list, &text(&1))
      true -> fatal(list)
    end
  end
  
  defp text(xmlObj(value: value, type: :number)), do: List.to_string(value) |> String.to_integer()
  defp text(xmlObj(value: value)), do: List.to_string(value)

  defp text(term), do: fatal(term)

  defp parsable(term) do
    Record.is_record(term, :xmlText) or Record.is_record(term, :xmlElement) or
      Record.is_record(term, :xmlAttribute)
  end

  defp fatal(term) do
    raise "Could not extract text value for xmerl node #{inspect(term)}"
  end
end
