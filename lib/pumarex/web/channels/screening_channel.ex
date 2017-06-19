defmodule Pumarex.Web.ScreeningChannel do
  use Pumarex.Web, :channel
  alias Pumarex.Web.Presence
  alias Pumarex.Accounts.User

  def join("screening:" <> _screening_id, payload, socket) do
    if authorized?(payload) do
      send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_info(:after_join, socket) do
    user = Guardian.Phoenix.Socket.current_resource(socket)
    push socket, "presence_state", Presence.list(socket)
    {:ok, _} = Presence.track(socket, user.id, %{
      full_name: User.full_name(user),
      avatar: User.avatar_url(user)
    })
    {:noreply, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (screening:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
