### FAQ

Question: My USB WiFi adapter is showing up as a CDROM or Flash drive
instead of a WiFi adapter. What is the problem?

Answer: Your Realtek USB WiFi adapter showing up as a CDROM or Flash
drive (often with ID 0bda:1a2b) instead of functioning as a network
adapter (such as ID 35bc:0102 or similar) is likely due to a
"mode-switching" issue. Some USB WiFi adapters include onboard memory
that contains drivers or installation software for Windows. When plugged
into a system for the first time, they initially present themselves as a
virtual CD-ROM or Flash driver containing the drivers.

In Linux, the `usb_modeswitch` utility generally handles this issue but
there are situations where it does not work as expected.

 Your options:

1. Send your adapter back and get one that is single-state (no storage
onboard). If that is not possible then:

2. You need to check if the VID/PID for your adapter is in the 
usb_modeswitch data file. See the following link for more information:

https://github.com/morrownr/USB-WiFi/blob/main/home/How_to_Modeswitch.md

If you have exhausted recommendations from the information in item 2,
then:

3. You may be able to make the adapter work in wifi mode with the 
following method:

How to add kernel parameters with GRUB in Ubuntu:

Note: This method may vary by distro so if you are not using Ubuntu,
please consult the documentation for your distro.

Once your device has booted, use a text editor to open the following 
file:

$ sudo nano /etc/default/grub

Add parameters to GRUB_CMDLINE_LINUX while keeping the following in
mind:

Enter parameters inside the double-quotes

Leave a space before each new parameter

Don’t add space round = and other punctuations for each key-value

Don’t add line breaks

If your original line looks like:

GRUB_CMDLINE_LINUX="quiet"

Then your updated line should read like:

GRUB_CMDLINE_LINUX="quiet usb-storage.quirks=0bda:1a2b:i"

Note: If the storage VId/PID (ID) i not 0bda:1a2b, you will need to
change 0bda:1a2b to the storage mode VID/PID of your adapter.

Save and close the editor.

Update GRUB with its new configuration:

$ sudo update-grub

$ sudo reboot

Note: If your distro does not use grub, the RasPiOS is an example, you
will need to read your distro docs to see how to do the above.

Example for Raspberry Pi OS:

$ sudo nano /boot/firmware/cmdline.txt

add the following to the end of the `console=` line:

usb-storage.quirks=0bda:1a2b:i

Save, close the editor and reboot.

-----

Secure Boot Information

Question: The driver installation script completed successfully and the
driver is installed but does not seem to be working. What is wrong?

Answer: This question often comes up after installing the driver to a
system that has Secure Boot on. To test if there is a Secure Boot related
problem, turn secure boot off in the system BIOS and reboot.  If the driver
works as expected after reboot, then the problem is likely related to
Secure Boot.

What will increase my chances of having a sucessessful installation on a
system that has Secure Boot on?

First and foremost, make sure Secure Boot is on when you initially install
your Linux distro. If your Linux distro was installed with Secure Boot off,
the easiest solution is likely to do a clean reinstallation with Secure Boot
on.

Ubuntu is used as the example but other distros should be similar to one
degree or another. During the installation there may be a box on one of
installation pages that will appear if the installation program detects
that Secure Boot is on. You will need to check the appropriate box and
supply a password. You can use the same password that you use for the system
if you wish. After the installation and reboot completes, the first screen
you should see is the mokutil screen. Mokutil will guide you through the
process of setting up your system to support Secure Boot. If you are unsure
what to do, I recommend you seek guidance from your distro documentation or
user forums. Having Secure Boot properly set up in your installation is very
important.

The `install-driver.sh` script currently supports Secure Boot if `dkms`
is installed. Here is a link to the `dkms` website. There is information
regarding Secure Boot in two sections in the `README`.

https://github.com/dell/dkms

Here is a link regarding Debian and Secure Boot:

https://wiki.debian.org/SecureBoot

There is work underway to add Secure Boot support for systems that do not
have `dkms` available or if a manual installation is desired.

If you are using a basic command line (non-dkms) installation, see the
following section in the Installation Steps part of the README:

If you use the `install-driver.sh` script and see the following message

`SecureBoot enabled - read FAQ about SecureBoot`

You need to read the following:

The MOK managerment screen will appear during boot:

`Shim UEFI Key Management"

`Press any key...`

Select "Enroll key"

Select "Continue"

Select "Yes"

When promted, enter the password you entered earlier.

If you enter the wrong password, your computer will not be bootable. In
this case, use the BOOT menu from your BIOS to boot then as follows:

```
sudo mokutil --reset
```

Restart your computer and use the BOOT menu from BIOS to boot. In the MOK
managerment screen, select `reset MOK list`. Then Reboot and retry the
driver installation.

Manual Installation Instructions

It provides secure boot instructions.

-----

Question: Is WPA3 supported?

Answer: WPA3-SAE is supported. It works well on most modern Linux distros
but not all. Generally the reason for WPA3 not working on Linux distros is
that the distro has an old version of wpa_supplicant or Network Manager.
Your options are to upgrade to a more modern distro such as those released
after mid-2022 or compile and install new versions of wpa_supplicant and/or
Network Manager.

-----

Question: I bought two usb wifi adapters based on this chipset and am
planning to use both in the same computer. How do I set that up?

Answer: Realtek drivers do not support more than one adapter with the
same chipset in the same computer. You can have multiple Realtek based
adapters in the same computer as long as the adapters are based on
different chipsets.

Recommendation: If this is an important capability for you, I have tested
Mediatek adapters for this capability and it does work with adapters that
use the following chipsets: mt7921au, mt7612u and mt7610u.

-----

Question: Why do you recommend Mediatek based adapters when you maintain
this repo for a Realtek driver?

Answer: Many new and existing Linux users already have adapters based on
Realtek chipsets. This repo is for Linux users to support their existing
adapters but my STRONG recommendation is for Linux users to seek out USB
WiFi solutions based on Mediatek chipsets. Mediatek is making and
supporting their drivers per Linux Wireless Standards guidance per the
Linux Foundation. This results in far fewer compatibility and support
problems. More information and recommended adapters shown at the
following site:

https://github.com/morrownr/USB-WiFi

-----

Question: Will you put volunteers to work?

Answer: Yes. Post a message in `Issues` if interested.

-----

Question: I am having problems with my adapter and I use Virtualbox?

Answer: This [article](https://null-byte.wonderhowto.com/forum/wifi-hacking-attach-usb-wireless-adapter-with-virtual-box-0324433/) may help.

-----

Question: Can you provide additional information about monitor mode?

Answer: Realtek adapters generally do not support monitor mode very well
so I recommend you but an adapter with a Mediatek chip:

https://github.com/morrownr/USB-WiFi

-----

Question: When running `sudo sh install-driver.sh` on my RasPi 4B or
400, I see the following:

```
Your kernel header files aren't properly installed.
Please consult your distro documentation or user support forums.
Once the header files are properly installed, please run...
```

Answer: The Pi 4/400 firmware now prefers the 64-bit kernel if one
exists so even if you installed the 32 bit version of the RasPiOS,
you may now have the 64 bit kernel active.

The fix:

add the following to /boot/config.txt and reboot:

arm_64bit=0

Reference:

https://forums.raspberrypi.com/viewtopic.php?p=2091532&hilit=Tp+link#p2091532

Note to RasPiOS devs: We really really wish you would consider the 
consequences of the changes you make. Thank you.

-----
