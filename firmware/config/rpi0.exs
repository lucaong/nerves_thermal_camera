import Config

config :nerves, :firmware, fwup_conf: "config/rpi0/fwup.conf"

config :firmware,
  indicators: %{
    default: %{
      green: "led0"
    }
  }
