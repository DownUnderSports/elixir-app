defmodule DownUnderSportsWeb.PageChannelTest do
  use DownUnderSportsWeb.ChannelCase

  setup do
    {:ok, _, socket} =
      socket(DownUnderSportsWeb.UserSocket, "user_id", %{user_id: 1})
      |> subscribe_and_join(DownUnderSportsWeb.PageChannel, "page:lobby", %{})

    {:ok, socket: socket}
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push socket, "ping", %{"hello" => "there"}
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "shout broadcasts to page:lobby", %{socket: socket} do
    push socket, "shout", %{"hello" => "all"}
    assert_broadcast "shout", %{"hello" => "all"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
  end
end
