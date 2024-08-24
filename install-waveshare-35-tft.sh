#!/bin/bash

function pre_umount_final_image__install_overlays() {
    display_alert "Installing Waveshare 3.5 TFT overlays" "info"
    run_host_command_logged cp -v "${EXTENSION_DIR}/overlays/*.dtbo" "${MOUNT}/boot/firmware/overlays"
}

# ---------------------------------------------------------------------------------------------------
# Variables:
#   - **EXT_INSTALL_WAVESHARE_35_TFT_OVERLAY** - name of the overlay to be used in config.txt. **Default**: waveshare35a
#   - **EXT_INSTALL_WAVESHARE_35_TFT_SPI_SPEED** - TFT SPI speed to be set in config.txt. **Default**: 20000000
#   - **EXT_INSTALL_WAVESHARE_35_TFT_ROTATE** - Display rotation to be set in config.txt.
#                                               One of: 0, 90, 180, 270. Other values will be accepted by extension, but ignored by driver. **Default**: 270

function pre_umount_final_image__550_update_config() {
    if [[ -z "${EXT_INSTALL_WAVESHARE_35_TFT_OVERLAY}" ]]; then
        EXT_INSTALL_WAVESHARE_35_TFT_OVERLAY="waveshare35a"
    fi
    if [[ -z "${EXT_INSTALL_WAVESHARE_35_TFT_SPI_SPEED}" ]]; then
        EXT_INSTALL_WAVESHARE_35_TFT_SPI_SPEED=20000000
    fi
    if [[ -z "${EXT_INSTALL_WAVESHARE_35_TFT_ROTATE}" ]]; then
        EXT_INSTALL_WAVESHARE_35_TFT_ROTATE=270
    fi

    display_alert "Update config for Waveshare 3.5 TFT, overlay ${EXT_INSTALL_WAVESHARE_35_TFT_OVERLAY}" "info"
    FILENAME="${MOUNT}/boot/firmware/config.txt"
    printf "\n# ${BASH_SOURCE[0]}" >>"${FILENAME}"
    printf "\n# TFT display config" >>"${FILENAME}"
    printf "\ndtparam=spi=on" >>"${FILENAME}"
    printf "\ndtoverlay=${EXT_INSTALL_WAVESHARE_35_TFT_OVERLAY},speed=${EXT_INSTALL_WAVESHARE_35_TFT_SPI_SPEED},rotate=${EXT_INSTALL_WAVESHARE_35_TFT_ROTATE}\n" >>"${FILENAME}"
    printf "\nignore_lcd=0" >>"${FILENAME}" >>"${FILENAME}"

}

# ---------------------------------------------------------------------------------------------------
# Variables:
#   - **EXT_INSTALL_WAVESHARE_35_TFT_X11** - if set to "yes" X11 related configuration will be installed. **Default**: unset

function pre_umount_final_image__600_install_x11_requirements() {

    if [[ "${EXT_INSTALL_WAVESHARE_35_TFT_X11}"=="yes" ]]; then
        display_alert "Install packages for Waveshare 3.5 TFT, overlay ${EXT_INSTALL_WAVESHARE_35_TFT_OVERLAY}" "info"

        chroot_sdcard_apt_get_install xserver-xorg-video-fbdev

        display_alert "Install configs for Waveshare 3.5 TFT, overlay ${EXT_INSTALL_WAVESHARE_35_TFT_OVERLAY}" "info"

        run_host_command_logged mkdir -p "${MOUNT}/usr/share/X11/xorg.conf.d"
        run_host_command_logged install -m 644 "${EXTENSION_DIR}/root/usr/share/X11/xorg.conf.d/40-libinput.conf" "${MOUNT}/usr/share/X11/xorg.conf.d/40-libinput.conf"
        run_host_command_logged install -m 644 "${EXTENSION_DIR}/root/usr/share/X11/xorg.conf.d/99-fbturbo.conf" "${MOUNT}/usr/share/X11/xorg.conf.d/99-fbturbo.conf"
        run_host_command_logged mkdir -p "${MOUNT}/etc/X11/xorg.conf.d/"
        run_host_command_logged install -m 644 "${EXTENSION_DIR}/root/etc/X11/xorg.conf.d/99-calibration.conf" "${MOUNT}/etc/X11/xorg.conf.d/99-calibration.conf"
    fi
}
