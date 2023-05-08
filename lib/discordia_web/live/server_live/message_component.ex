defmodule DiscordiaWeb.ServerLive.MessageComponent do
  use DiscordiaWeb, :live_component

  alias Discordia.Servers
  alias Discordia.Servers.Message

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.simple_form
        for={@form}
        id="message-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:context]} type="textarea" />
        <:actions>
          <.button phx-disable-with="Saving...">Send Message</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def mount(socket) do
    changeset = Servers.change_message(%Message{})

    {:ok,
     socket
     |> assign_form(changeset)}
  end

  @impl true
  def update(assigns, socket) do
    socket =
      socket
      |> assign(assigns)

    {:ok, socket}
  end

  @impl true
  def handle_event("validate", %{"message" => message_params}, socket) do
    changeset =
      %Message{}
      |> Servers.change_message(message_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"message" => message_params}, socket) do
    case Servers.create_message(
           socket.assigns.current_user.id,
           socket.assigns.server.id,
           message_params
         ) do
      {:ok, _message} ->
        changeset = Servers.change_message(%Message{})

        {:noreply, assign_form(socket, changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end
end
