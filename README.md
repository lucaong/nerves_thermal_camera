# Nerves Thermal Camera

This project is an Elixir Nerves firmware that implements a thermal camera using
the Melexis MLX90640 sensor. It is tested on a Raspberry Pi Zero W, but it
should work on other WiFi-enabled Raspberri Pi models too.

Other platforms supported by Nerves _should_ work too, but may need
modifications.

![Nerves Thermal Camera](https://github.com/fhunleth/fwup/raw/master/docs/thermalcam-image-1541268575911.png)

# Build and installation

The pre-requisite is that you have installed the [Elixir
language](https://elixir-lang.org) and [Nerves](https://nerves-project.org). You
can find installation guides on their respective websites.

Then:

  1. Clone or download the repository
  2. Go to the `ui` folder and run:
      ```bash
      mix deps.get
      cd assets
      npm install
      node_modules/brunch/bin/brunch build --production
      cd ../
      mix phx.digest
      ```
  3. Then go to the `firmware` folder and run:
     ```bash
     export MIX_TARGET=rpi0 # (or another Nerves target like `rpi3`)
     export MIX_ENV=prod
     export NERVES_NETWORK_SSID=WiFiSSID    # substitute WiFiSSID with your WiFi SSID
     export NERVES_NETWORK_PSK=WiFiPassword # substitute WiFiPassword with your WiFi password
     mix deps.get
     mix firmware
     ```
  7. Insert an SD card in your computer, and from the same terminal window as
     before run `mix firmware.burn` to burn the firmware on the SD card

You should be ready to go.


# Usage

  1. Follow the instructions above to burn a firmware image on the SD card
  2. Wire the MLX90640 to the Raspberry Pi
  3. Turn on the Raspberry Pi and wait for it to connect to the WiFi network
  4. From another device (computer or smartphone) connected to the same WiFi,
     visit http://thermalcam.local
