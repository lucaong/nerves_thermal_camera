defmodule Mlx90640 do
  use GenServer

  defmodule Frame do
    @moduledoc false
    defstruct data: []
  end

  @rows 32
  @cols 24
  @max 38
  @min 19

  @type frame_rate :: 1 | 2 | 4 | 8 | 16 | 32 | 64

  @spec start_link(pid, [ frame_rate: frame_rate ], [ term ]) :: GenServer.on_start()
  def start_link(receiver, mlx_opts \\ [], opts \\ []) do
    frame_rate = Keyword.get(mlx_opts, :frame_rate, 2)

    if Enum.member?([1, 2, 4, 8, 16, 32, 64], frame_rate) do
      arg = %{ receiver: receiver, frame_rate: frame_rate }
      GenServer.start_link(__MODULE__, arg, opts)
    else
      { :error, "frame rate #{frame_rate} not supported" }
    end
  end

  @spec stop(GenServer.server()) :: :ok
  def stop(pid) do
    GenServer.cast(pid, :stop)
  end

  # GenServer callbacks

  def init(%{ receiver: receiver, frame_rate: frame_rate }) do
    interval = div(1000, frame_rate)
    schedule_frame(interval)
    {:ok, %{ receiver: receiver, interval: interval }}
  end

  def handle_info(:frame, state = %{ receiver: receiver, interval: interval }) do
    send(receiver, %Frame{ data: random_data() })
    schedule_frame(interval)
    { :noreply, state }
  end

  def handle_cast(:stop, state) do
    { :stop, :normal, state }
  end

  # Helper functions

  defp schedule_frame(interval) do
    Process.send_after(self(), :frame, interval)
  end

  defp random_data() do
    1..@cols |> Enum.map(fn _ ->
      1..@rows |> Enum.map(fn _ ->
        (:rand.uniform() * (@max - @min) + @min) |> Float.round(2)
      end)
    end)
  end
end
