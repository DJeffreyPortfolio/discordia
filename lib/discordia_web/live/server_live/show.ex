defmodule DiscordiaWeb.ServerLive.Show do
  use DiscordiaWeb, :live_view

  alias Discordia.Servers

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Servers.subscribe()
    end

    {:ok,
     socket
     |> stream(:messages, Servers.list_messages(id))}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:server, Servers.get_server!(id))}
  end

  @impl true
  def handle_info({{:saved, message}}, socket) do
    {:noreply, stream_insert(socket, :messages, message)}
  end

  defp page_title(:show), do: "Show Server"
  defp page_title(:edit), do: "Edit Server"
end
