# AAPWL
Auto Attachment Printer - Print attachments automatically from anywhere using DietPi &amp; Windows


INIT

Problem:

Right now we use CUPS on DietPi (with either Zeropi's or Raspberry Pi Zero W's) and print attachments from a certain sender automatically.
Because CUPS is not stable enough for this environment we created an alternative is needed.

Idea structure:

Get ARM device (Raspberry Pi Zero W or Zeropi) connected to the network at the client.
Set up the following:
- Zerotier (connecting to private network)
- usbip from Linux. This is finnicky but should work.
- Because the printer is connected to the Pi with usb we can forward it through our private local network (Zerotier)
- Use a Windows computer to automatically print the attachments from these clients.
