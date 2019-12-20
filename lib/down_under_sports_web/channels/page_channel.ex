defmodule DownUnderSportsWeb.PageChannel do
  use DownUnderSportsWeb, :channel
  alias DownUnderSportsWeb.Presence

  # def join("page:lobby", _params, socket) do
  #   send(self(), :after_join)
  #   {:ok, socket}
  # end

  def join("page:" <> _room_id, _params, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    push(socket, "presence_state", Presence.list(socket))
    {:ok, _} = Presence.track(socket, socket.assigns.user_id, %{
      online_at: inspect(System.system_time(:second))
    })
    {:noreply, socket}
  end

  @doc """
  Handle the "ping" event exclusively
  """
  # def handle_in("ping", params, socket) do
  #   broadcast!(socket, "ping", params)
  #   {:noreply, socket}
  # end
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  def handle_in(msg, params, socket) do
    broadcast!(socket, msg, params)
    {:noreply, socket}
  end

  def handle_out(type, msg, socket) do
    push(socket, type, msg)
    {:noreply, socket}
  end
end
