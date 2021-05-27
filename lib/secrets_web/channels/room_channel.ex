defmodule PhoenixStarter.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    # sender enters
    # send :on_join
    #   generate room-name
    #   join(room:<room-name>, {}, socket)

    {:ok, socket}
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end
end
