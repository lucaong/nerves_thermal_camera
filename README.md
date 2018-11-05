# Nerves Thermal Camera

This project is an Elixir Nerves firmware that implements a thermal camera using
the Melexis MLX90640 sensor. It is tested on a Raspberry Pi Zero W, but it
should work on other WiFi-enabled Raspberri Pi models too.

Other platforms supported by Nerves _should_ work too, but may need
modifications.

![Nerves Thermal Camera](https://raw.githubusercontent.com/lucaong/nerves_thermal_camera/master/thermalcam-image-1541286020608.png)

# Build and installation

The pre-requisite is that you have installed the [Elixir
language](https://elixir-lang.org), [Nerves](https://nerves-project.org), and
[Node.js](https://nodejs.org/en/). You can find installation guides on their
respective websites.

Then:

  1. Clone or download the repository and open your terminal
  2. `cd` into the project directory and the following environment variables:
     ```bash
     export MIX_TARGET=rpi0 # (or another Nerves target like `rpi3`)
     export MIX_ENV=prod
     # In the following two commands, replace `your_ssid` with your WiFi SSID
     # and `your_psk` with your WiFi password
     export NERVES_NETWORK_SSID=your_ssid
     export NERVES_NETWORK_PSK=your_psk
     ```
  3. Run `make firmware` to build the firmware
  4. Insert the SD card in your computer and, from the same terminal window as
     before, run `make firmware.burn` to burn the firmware on the SD card.

The SD card should now be ready.


# Usage

  1. Follow the instructions above to burn a firmware image on the SD card
  2. Wire the MLX90640 to the Raspberry Pi
  3. Turn on the Raspberry Pi and wait for it to connect to the WiFi network
  4. From another device (computer or smartphone) connected to the same WiFi,
     visit http://thermalcam.local
