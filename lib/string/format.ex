defmodule String.Format do
  def titleize(string) do
    String.trim(string)
    |> String.split(" ", trim: true)
    |> Enum.map(
        fn(word) ->
          case String.downcase(word) do
            "of" -> "of"
            "the" -> "the"
            "and" -> "and"
            _ -> String.capitalize(word)
          end
        end
      )
    |> Enum.join(" ")
  end

  def abbr(string, char_count) do
    string
    |> String.trim()
    |> String.split(" ", trim: true)
    |> Enum.join("")
    |> String.upcase()
    |> (&(String.slice(&1, 0, min(String.length(&1), char_count)))).()
  end

  def abbr(string) do
    abbr(string, 2)
  end
end
