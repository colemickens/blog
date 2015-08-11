---
title: "Arch Linux on the Chromebook Pixel LS (2015)"
date: "2015-04-07"
---

(Updated April 24, 2015)

The Chromebook Pixel (2015) is one of my favorite new toys. Another fantastic revision of hardware from Google, and still relatively easy to get Linux on it. As it stands, this is easily my favorite hardware for running Linux on. That having been said, I've been telling others that I am running GNOME3 happily on my Pixel as a day-to-day machine and they have been asking for details. Hopefully this post can serve as an outline of the steps needed!

Note, all of the credit goes to [tsowell](https://github.com/tsowell/linux-samus) and the [Chromium page on the Chromebook Pixel 2015](https://www.chromium.org/chromium-os/developer-information-for-chrome-os-devices/chromebook-pixel-2015). I've just recombined and referenced their work here.

## Put the Pixel into Dev Mode

Shut down the Chromebook Pixel. Hold `Escape` and `Refresh` and tap the power button long enough for the laptop to begin powering on (the display and keyboard backlight will turn on). This will take you to a scary warning screen, whereupon you have to know to press `Ctrl+D`. This will initiate the transition into development mode. Follow the on-screen instructions.

Your Pixel will restart to the scary Development Mode boot screen that you will now see at each (re)boot. Pressing `Ctrl+D` will allow it to continue and boot into ChromeOS normally. However, this time, rather than logging into ChromeOS, you can immediately press `Ctrl+Alt+F2` to get to a TTY. From here, you'll issue the following commands to enable legacy (non-EFI, aka SeaBIOS) and usb booting:

```
sudo crossystem dev_boot_legacy=1
sudo crossystem dev_boot_usb=1
```


## Install Arch Linux

After issuing the `crossystem` commands, simply reboot the machine. This time, press `Ctrl+L` to engage the legacy SeaBIOS boot mode, and then press `F2` to get to the boot menu and choose your Arch installation media.

From here, well, hopefully you know the drill. The [Arch Wiki](https://wiki.archlinux.org/) is fantastic. Follow the [Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide), removing the GPT and performing an MBR/Grub2 install.


## Install the custom kernel

[raphael](https://github.com/raphael) is maintaining [a set of kernel patches for Arch and Ubuntu users](https://github.com/raphael/linux-4.1-samus). The patched kernel can be installed via the [linux-samus](https://aur.archlinux.org/packages/linux-samus/) package from the AUR. I assume that [yaourt](https://wiki.archlinux.org/index.php/Yaourt) is already installed; if you use a different [AUR helper](https://wiki.archlinux.org/index.php/AUR_helpers) then substitute as appropriate.

Note, you'll need to allow GPG to download keys in order for the package to be able to verify the tar archives that they download.

```
echo "keyserver-options auto-key-retrieve" >> ~/.gnupg/gpg.conf
yaourt -S linux-samus
```

Finally, running `grub-mkconfig > /boot/grub/grub.cfg` will create a new grub boot configuration (it will default to the new `linux-samus` kernel).

## Fixing touchpad, touchscreen, sounds

The README.md explains the steps needed to enable audio and touch(pad|screen) drivers. I did make some changes to my pulseaudio configuration (`/etc/pulse/default.pa`) to set the default device -- I added `load-module module-alsa-sink device=hw:0,0 sink_name=default` before line 47 and added `set-default-sink default` to the very bottom.


## FAQ

### 1. How can I bypass the scary screen on boot?

You can't, without opening your Pixel, removing the write-protect screw and then issuing a command to change the GBB (Google Binary Block) flags. These flags control aspects of the boot such as what devices to boot from, whether to require the bits be signed by Google, etc. These are the first step in ChromeOS's verified boot.

If these flags were able to be modified without opening the device, then one could spoof ChromeOS and steal user secrets. Opening the device, apparently, is enough of a deterrent.

### 2. Do I need to flash a custom SeaBIOS?

Probably not. The SeaBIOS that ships on the device is capable of booting Linux, and initiazes devices properly such that suspend/resume work as expected. The original Chromebook Pixel did not initialize the TPM properly, leading to reboots instead of resuming.

### 3. Do I need to worry about my Pixel losing power completely?

No! The original Chromebook Pixel persisted developer mode flags in a volatile location which could be wiped in some cases. This was a real problem if one had installed Linux, as it meant that you could no longer boot until you restored ChromeOS, fixed flags and reinstalled Linux. (If you happen to get into such a state with your original Pixel (2013), there is an easier way which can be found on the [Chromium Wiki](https://sites.google.com/a/chromium.org/dev/chromium-os/developer-information-for-chrome-os-devices/workaround-for-battery-discharge-in-dev-mode).)

### 4. What doesn't work?

The USB3.1 Type-C to DisplayPort adapter does not work with displays that are in DisplayPort 1.2 (MST) mode. Additionally, my monitors that were once put into this mode and then switched back, actually had to be factory reset to work with the adapter.
