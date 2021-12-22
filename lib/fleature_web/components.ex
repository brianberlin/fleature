defmodule FleatureWeb.Components do
  @moduledoc """
  Including some styles that should always be available
  p-0 p-px p-0.5 p-1 p-1.5 p-2 p-2.5 p-3 p-3.5 p-4 p-5 p-6 p-7 p-8 p-9 p-10 p-11 p-12 p-14 p-16 p-20 p-24 p-28 p-32 p-36 p-40 p-44 p-48 p-52 p-56 p-60 p-64 p-72 p-80 p-96
  w-0	w-px w-0.5 w-1 w-1.5 w-2 w-2.5 w-3 w-3.5 w-4 w-5 w-6 w-7 w-8 w-9 w-10 w-11 w-12 w-14 w-16 w-20 w-24 w-28 w-32 w-36 w-40 w-44 w-48 w-52 w-56 w-60 w-64 w-72 w-80 w-96 w-auto w-1/2 w-1/3 w-2/3 w-1/4 w-2/4 w-3/4 w-1/5 w-2/5 w-3/5 w-4/5 w-1/6 w-2/6 w-3/6 w-4/6 w-5/6 w-1/12 w-2/12 w-3/12 w-4/12 w-5/12 w-6/12 w-7/12 w-8/12 w-9/12 w-10/12 w-11/12 w-full w-screen w-min w-max w-fit
  h-0	h-px h-0.5 h-1 h-1.5 h-2 h-2.5 h-3 h-3.5 h-4 h-5 h-6 h-7 h-8 h-9 h-10 h-11 h-12 h-14 h-16 h-20 h-24 h-28 h-32 h-36 h-40 h-44 h-48 h-52 h-56 h-60 h-64 h-72 h-80 h-96 h-auto h-1/2 h-1/3 h-2/3 h-1/4 h-2/4 h-3/4 h-1/5 h-2/5 h-3/5 h-4/5 h-1/6 h-2/6 h-3/6 h-4/6 h-5/6 h-1/12 h-2/12 h-3/12 h-4/12 h-5/12 h-6/12 h-7/12 h-8/12 h-9/12 h-10/12 h-11/12 h-full h-screen h-min h-max h-fit
  """
  use FleatureWeb, :components

  alias FleatureWeb.Components.Containers
  alias FleatureWeb.Components.FormElements
  alias FleatureWeb.Components.Header
  alias FleatureWeb.Components.Icons
  alias FleatureWeb.Components.Links
  alias FleatureWeb.Components.Table
  alias FleatureWeb.Components.Type

  defdelegate link(assigns), to: Links
  defdelegate table(assigns), to: Table
  defdelegate icon(assigns), to: Icons
  defdelegate header(assigns), to: Header

  defdelegate container(assigns), to: Containers
  defdelegate form_container(assigns), to: Containers

  defdelegate submit_button(assigns), to: FormElements
  defdelegate text_input(assigns), to: FormElements
  defdelegate email_input(assigns), to: FormElements
  defdelegate password_input(assigns), to: FormElements
  defdelegate checkbox_input(assigns), to: FormElements
  defdelegate hidden_input(assigns), to: FormElements
  defdelegate toggle_input(assigns), to: FormElements

  defdelegate h1(assigns), to: Type
  defdelegate h2(assigns), to: Type
  defdelegate h3(assigns), to: Type
  defdelegate p(assigns), to: Type
  defdelegate ul(assigns), to: Type
  defdelegate li(assigns), to: Type

  def get_classes(assigns, default_classes) do
    classes = Map.get(assigns, :class, "")
    default_classes <> " " <> classes
  end
end
