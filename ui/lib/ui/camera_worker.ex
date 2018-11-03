defmodule Ui.CameraWorker do
  use GenServer

  def start_link(mlx_opts \\ [], opts \\ []) do
    GenServer.start_link(__MODULE__, mlx_opts, opts)
  end

  # GenServer callbacks

  def init(mlx_opts) do
    { :ok, mlx } = Mlx90640.start_link(self(), mlx_opts)
    { :ok, %{ mlx: mlx } }
  end

  def handle_info(%Mlx90640.Frame{ data: data }, state) do
    UiWeb.CameraChannel.broadcast_frame(data)
    { :noreply, state }
  end

  def terminate(_reason, %{ mlx: mlx }) do
    Mlx90640.stop(mlx)
    :ok
  end
end
