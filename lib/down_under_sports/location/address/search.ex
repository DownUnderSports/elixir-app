defmodule DownUnderSports.Location.Address.Search do
  @moduledoc """
  TSVector Searching on Address
  """

  import Ecto.Query

  # https://www.postgresql.org/docs/current/static/textsearch-controls.html#TEXTSEARCH-PARSING-QUERIES
  defmacro plain_to_tsquery(search_term) do
    quote do
      fragment("plainto_tsquery('english', ?)", unquote(search_term))
    end
  end

  defmacro ts_search_fragment(tsv, search_term) do
    quote do
      fragment("? @@ ?", unquote(tsv), unquote(search_term))
    end
  end

  # https://www.postgresql.org/docs/current/static/textsearch-controls.html#TEXTSEARCH-RANKING
  defmacro ts_rank_cd(tsv, search_term) do
    quote do
      fragment("ts_rank_cd(?, ?)", unquote(tsv), unquote(search_term))
    end
  end

  @spec run(Ecto.Query.t(), any()) :: Ecto.Query.t()
  def run(query, search_term) do
    query
    |> where([address], ts_search_fragment(address.tsvector, plain_to_tsquery(^normalize_search(search_term))))
    |> order_by([address], desc: ts_rank_cd(address.tsvector, plain_to_tsquery(^normalize_search(search_term))))
  end

  defp normalize_search(term), do: String.downcase(term)
end
