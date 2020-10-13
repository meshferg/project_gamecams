# Cuddeback Cuddelink camera network: Toshiba FlashAir WiFi SD card details
This repository provides some details on hardware and software to enable a Toshiba FlashAir WiFi SD card to transmit images collected by a gamecamera network. This documentation and code is specific to Toshiba FlashAir cards running in a system as described [here](../README.md).

## Hardware
(Coming soon.)

## Software
The [sd_wlan/software]() directory contains the files that go on the top level of the SD card.

## 
In the root directory of the card:
 - Upload.lua: this script is triggered whenever an image file is dropped onto the SD card by the Cuddeback Home unit. Specifying that this script file is the one run is the last line in the 'CONFIG' file, by the 'LUA_SD_EVENT' parameter.
 - Settings.lua: this file needs to be edited to specify FTP server parameters. I.e. where do the files go.

 In the SD_LAN subdirectory of the card:
  - CONFIG: this is a boot-time file that tells the card how to activate on the network. Here are some things to note:
   - Specify your LAN IP settings for the card. I had no reliable success using DHCP, so always used fixed IP address.
   - If you take the card out of the Home unit and look at on your PC, you will notice the WiFi SSID password has probably gone away (elided). You will likely need to edit the CONFIG file and put it back in. The SD card deletes the password upon booting, and, I suspect, stores it in some NV RAM.