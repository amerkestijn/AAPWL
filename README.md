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

Research:
I got the Linux printer to Windows connection working.
There were some small problems that had to be resolved so here i'll write how i did it:

Linux:
- apt-get install usbip
- sudo modprobe usbip-core
- sudo modprobe usbip-host
- sudo usbipd -D
- Check your usb devices: sudo usbip list -l
- Now bind the usb device(s) you want to share: sudo usbip bind --busid=1-1 (1-1 = the bus id in my case, replace this with your bus id)
- Check if the usb device is actually available for other devices now: usbip list -r localhost
- You can add the files to boot by nano /etc/modules and adding the following : 
usbip-core 
usbip-host
- sudo crontab -e
- add the following line (with your own bus id): @reboot  /usr/sbin/usbipd -D&&/usr/sbin/usbip bind --busid=1-1

Windows:
- Get the source code (+ the additional files) from: https://github.com/cezanne/usbip-win
- Put all the files in a directory
- Put Windows in Test Mode (signing): bcdedit /set testsigning on
- Install the cert by going to the directory you made & go into the "driver" directory, execute "usbip_test.pfx"
- Choose for Local Machine and click Next -> Next -> password = usbip -> Next -> Place all certificates in the following store: Browse & choose for: Trusted Root Certification Authorities
- Do it again but place it in "Trusted Publishers" this time
- Open Powershell (as administrator) cd to the directory you made
- Execute the following command: ./usbip.exe install_ude
- It can happen that the system asks for a reboot. Do that & execute the command again in Powershell
- Now we can establish the connection with the usb server by executing the following command: ./usbip.exe attach_ude -r your-ip-here -b usb-bus-id-here
- usbip: error: walker_devpath....... is normal and does not matter. The Powershell window has to remain open & your usb device should be reachable now.
