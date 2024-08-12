# ban-hosts

Script that stops me from wasting time by updating `/etc/hosts` to block specific domains.

Usage: `sudo ./ban-hosts.sh [path_to_input_hosts_file]` to add entries. Input file should have 1 host per line. Hosts file defaults to `hosts.txt`.

Also includes 1-liner script, `sort-entries.sh`, to sort + dedupe entries in the hosts list file. Usage: `./sort-entries.sh [path_to_hosts_file]`.

Largely written by Claude 3.5.
