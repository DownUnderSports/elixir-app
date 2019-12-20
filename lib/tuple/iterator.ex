defmodule Tuple.Iterator do
  def each(tuple, f) do
    tuple_range(tuple)
      |>  Enum.each(
            fn i ->
              f.({i, elem(tuple, i)})
            end
          )
    tuple
  end

  defp tuple_range(tuple) do
    case tuple_size(tuple) do
      0 -> []
      i -> 0..(i - 1)
    end
  end
end
