defmodule FleatureWeb.Components.Table do
  @moduledoc false
  use FleatureWeb, :components

  import FleatureWeb.Components

  require Integer

  def table(assigns) do
    class = get_classes(assigns, "flex flex-col mt-5")

    ~H"""
    <div class={class}>
      <div class="-my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
        <div class="py-2 align-middle inline-block min-w-full sm:px-6 lg:px-8">
          <div class="shadow overflow-hidden border-b border-gray-200 sm:rounded-lg">
            <table class="min-w-full divide-y divide-gray-200">
              <thead class="bg-gray-50">
                <tr>
                  <%= for col <- @col do %>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                      <%= col.label %>
                    </th>
                  <% end %>
                </tr>
              </thead>
              <tbody>
                <%= for {row, index} <- Enum.with_index(@rows) do %>
                  <tr class={if Integer.is_even(index), do: "bg-white", else: "bg-gray-50"}>
                    <%= for col <- @col do %>
                      <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-700">
                        <%= render_slot(col, row) %>
                      </td>
                    <% end %>
                  </tr>
                <% end %>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
