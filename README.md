Exml
====

[![Elixir CI](https://github.com/expelledboy/exml/actions/workflows/ci.yml/badge.svg)](https://github.com/expelledboy/exml/actions/workflows/ci.yml)
[![Hex.pm](https://img.shields.io/hexpm/v/exml.svg)](https://hex.pm/packages/exml)
[![Hex.pm](https://img.shields.io/hexpm/dt/exml.svg)](https://hex.pm/packages/exml)

Add to mix.exs

```elixir
  defp deps() do
    [
      {:exml, "~> 0.1.2"}
    ]
  end
```

Basic usage

```elixir
xml = """
<?xml version="1.0" encoding="UTF-8"?>
<bookstore>
    <book>
        <title lang="en">Harry Potter</title>
        <price>29.99</price>
    </book>
    <book>
        <title lang="en">Learning XML</title>
        <price>39.95</price>
    </book>
</bookstore> 
"""

doc = Exml.parse xml

Exml.get doc, "//book[1]/title/@lang"
#=> "en"

Exml.get doc, "//title"
#=> ["Harry Potter", "Learning XML"]
```

See [w3schools](https://www.w3schools.com/xml/xpath_syntax.asp) for details about xpath!
