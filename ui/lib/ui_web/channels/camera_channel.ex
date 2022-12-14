defmodule UiWeb.CameraChannel do
  use UiWeb, :channel

  @impl true
  def join("camera:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

  def broadcast_frame(data) do
    UiWeb.Endpoint.broadcast("camera:lobby", "frame", %{ data: data })
  end
end
