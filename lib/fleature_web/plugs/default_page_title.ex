defmodule FleatureWeb.Plugs.DefaultPageTitle do
  @moduledoc false
  import Plug.Conn, only: [assign: 3]

  def init(opts), do: opts

  def call(conn, _params) do
    page_title =
      conn
      |> Map.get(:path_info, [])
      |> Enum.map(&String.capitalize/1)
      |> add_site_name()
      |> Enum.join(" ")

    assign(conn, :page_title, page_title)
  end

  defp add_site_name([]), do: ["Fleature"]
  defp add_site_name(parts), do: parts ++ ["-", "Fleature"]
end
