import Config

config :nerves, :firmware, fwup_conf: "config/rpi0/fwup.conf"

config :led,
  indicators: %{
    default: %{
      green: "led0"
    }
  }
