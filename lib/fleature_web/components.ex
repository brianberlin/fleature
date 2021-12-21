defmodule FleatureWeb.Components do
  @moduledoc false
  use FleatureWeb, :components

  alias FleatureWeb.Components.Containers
  alias FleatureWeb.Components.FormElements
  alias FleatureWeb.Components.Links
  alias FleatureWeb.Components.Type
  alias FleatureWeb.Components.Table
  alias FleatureWeb.Components.Breadcrumbs

  defdelegate container(assigns), to: Containers
  defdelegate form_container(assigns), to: Containers
  defdelegate form_container_header(assigns), to: Containers
  defdelegate form_container_section(assigns), to: Containers

  defdelegate submit_button(assigns), to: FormElements
  defdelegate text_input(assigns), to: FormElements
  defdelegate email_input(assigns), to: FormElements
  defdelegate password_input(assigns), to: FormElements
  defdelegate checkbox_input(assigns), to: FormElements
  defdelegate hidden_input(assigns), to: FormElements

  defdelegate patch_link(assigns), to: Links
  defdelegate click_link(assigns), to: Links

  defdelegate h1(assigns), to: Type
  defdelegate h2(assigns), to: Type
  defdelegate h3(assigns), to: Type
  defdelegate p(assigns), to: Type
  defdelegate ul(assigns), to: Type
  defdelegate li(assigns), to: Type

  defdelegate table(assigns), to: Table

  defdelegate breadcrumbs(assigns), to: Breadcrumbs

  def get_classes(assigns, default_classes) do
    classes = Map.get(assigns, :class, "")
    default_classes <> " " <> classes
  end
end
