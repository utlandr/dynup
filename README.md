# dynup - a simple FreeDNS DNS update script

dynup is a DNS updater implemented in Bash. It pings a single set webserver for an external IP address periodically, determines change and appropriately updates the DNS of your server. This was primarily designed to get around the issue of a router being incapable of easily supplying an external IP address to an internal user. 

### Installation
Make the file executable (if it isn't already) using:
`chmod +x dynup`

And run with your personalized FreeDNS 'Direct URL' DNS update link:
`dynup -q <url>`

#### Improvements
I hope to add the following improvements in the future:

  - Multiple test webservers/option for users to determine a webserver themselves
  - Multiple servers to monitor (under the same subnet)
  - Alternative methods to the update process 
