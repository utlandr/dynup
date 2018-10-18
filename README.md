# dynup - a simple FreeDNS DNS update script

dynup is a DDNS updater implemented in Bash. It pings a single webserver for an external IP address periodically, determines change and appropriately updates the DNS of your server. This was primarily designed to get around the issue of a router being incapable of easily supplying an external IP address to an internal user. 

My script only requires a FreeDNS update URL. While this is safer than parsing login credentials, be aware that anyone with the update URL can redirect the domain name.

### Features
  - Script can detach from terminal and run in background (technically not a daemon)
  - Event logging
  - No login credentials required
  - Simple systemd setup 

### Installation

#### Command Line  
Make the file executable (if it isn't already) using:
`chmod +x dynup`

And run with your personalized FreeDNS 'Direct URL' DNS update link:
`dynup -q <url>`

#### Systemd (Debian)
Use `systemd-setup.sh` to set `dynup` as a systemd service. Alternatively, you can edit the included `dynup-template.service` file yourself.

### Options and Usage
```
Usage:	dynup [-d|-h|-v][-f <int>][-l <str>][-q <str>] 

-d	Detach process and run in background.
-f	Update frequency (seconds).
-h  	Show this help message.
-l	Log updates to a file.
-q	FreeDNS update url.
-v	Increase verbosity.

```

### Improvements
  - Multiple test webservers
  - Track multiple DNS entries
  - Alternative/safer methods to the update process 
  - Additional security methods (enforcing HTTPS)
