# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
import Config

Application.start(:nerves_bootstrap)

config :firmware, target: Mix.target()

config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"
config :nerves, source_date_epoch: "1577974981"

config :logger, backends: [RingLogger]

config :ui, UiWeb.Endpoint,
  url: [host: "thermalcam.local"],
  http: [port: 80, ip: {0, 0, 0, 0, 0, 0, 0, 0}],
  server: true,
  secret_key_base: "xOVJbs6T8CzNNiy05Xz3A1vLsWhic9SwhxWoEmfPk5zM3mQ5uoiSu4ILeemsUT3k",
  cache_static_manifest: "priv/static/cache_manifest.json",
  render_errors: [view: UiWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Ui.PubSub,
  live_view: [signing_salt: "1zOR8f9f"]


config :phoenix, :json_library, Jason

# For Devices that don't support usb gadget such as Raspberry Pi 1, 2, and 3:
# config :nerves_init_gadget,
#   address_method: :dhcp,
#   ifname: "eth0"

# Import target specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
# Uncomment to use target specific configurations

if Mix.target() != :host do
  import_config "target.exs"
end

if File.exists?(Path.join("config", "#{Mix.target()}.exs")) do
  import_config "#{Mix.target()}.exs"
end
