defmodule FleatureWeb.EnvironmentsLive.Create do
  @moduledoc false
  use FleatureWeb, :live_component

  alias Fleature.Environments
  alias Fleature.Schemas.Environment

  def update(assigns, socket) do
    changeset =
      Environment.insert_changeset(%Environment{}, %{
        project_id: assigns.project.id
      })

    socket =
      socket
      |> assign(:changeset, changeset)
      |> assign(:project, assigns.project)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.form_container>
        <:header>
          <.h2 class="text-center">Create an Environment</.h2>
        </:header>
        <:body>
          <.form class="environment-form" let={f} for={@changeset} phx-change="validate" phx-submit="save" phx-target={@myself}>
            <.text_input f={f} key={:name} />
            <.hidden_input f={f} key={:project_id} value={@project.id} />
            <.submit_button>Save</.submit_button>
          </.form>
        </:body>
      </.form_container>
    </div>
    """
  end

  def handle_event("validate", %{"environment" => params}, socket) do
    changeset = Environment.insert_changeset(%Environment{}, params)
    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"environment" => params}, socket) do
    case Environments.insert_environment(params) do
      {:ok, _environment} ->
        path = Routes.projects_path(FleatureWeb.Endpoint, :view, socket.assigns.project)

        {:noreply, push_redirect(socket, to: path)}

      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
