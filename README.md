# dynup - a simple FreeDNS DNS update script

dynup is a DDNS updater implemented in Bash. It pings a single webserver for an external IP address periodically, determines change and appropriately updates the DNS of your server. This was primarily designed to get around the issue of a router being incapable of easily supplying an external IP address to an internal user. 

My script only requires a FreeDNS update URL. While this is safer than parsing login credentials, be aware that anyone with the update URL can redirect the domain name.

### Installation
Make the file executable (if it isn't already) using:
`chmod +x dynup`

And run with your personalized FreeDNS 'Direct URL' DNS update link:
`dynup -q <url>`

#### Features

  - Script can detach from terminal (technically not a daemon).
  - Basic logging of key events (DNS not reachable, External IP change)

#### Improvements
Features that I am working on:

  - Multiple test webservers/option for users to determine a webserver themselves
  - Track multiple DNS entries
  - Alternative/safer methods to the update process 
  - Additional security methods (like enforcing HTTPS)
  - Better logging.
