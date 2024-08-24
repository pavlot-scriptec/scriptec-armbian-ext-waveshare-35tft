# Armbian extension to install Waveshare 3.5 TFT (A, B, B-V2) SPI driver.

This is [Armbian](https://www.armbian.com/) extension to enable [Waveshare 3.5 TFT SPI display](https://www.waveshare.com/wiki/3.5inch_RPi_LCD_(A))

It is based on [overlays](https://github.com/waveshare/LCD-show) provided by Waveshare

## Instalation

Clone this project to Armbian `userpatches/extensions` directory. Create it if it does not exists.

Next add `ENABLE_EXTENSIONS=install-waveshare-35-tft` parameter to your `./compile.sh` call

## Parameters

- **EXT_INSTALL_WAVESHARE_35_TFT_OVERLAY** - name of the overlay to be used in config.txt. **Default**: waveshare35a
- **EXT_INSTALL_WAVESHARE_35_TFT_SPI_SPEED** - TFT SPI speed to be set in config.txt. **Default**: 20000000
- **EXT_INSTALL_WAVESHARE_35_TFT_ROTATE** - Display rotation to be set in config.txt. One of: 0, 90, 180, 270. Other values will be accepted by extension, but ignored by driver. **Default**: 270
- **EXT_INSTALL_WAVESHARE_35_TFT_X11** - if set to "yes" X11 related configuration will be installed. **Default**: unset
