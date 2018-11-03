defmodule UiWeb.CameraChannel do
  use Phoenix.Channel

  def join("camera", _message, socket) do
    {:ok, socket}
  end

  def broadcast_frame(data) do
    UiWeb.Endpoint.broadcast("camera", "frame", %{ data: data })
  end
end
