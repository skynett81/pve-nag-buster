# pve-nag-buster 
Persistent license nag removal for Proxmox VE 5.x+

https://github.com/foundObjects/pve-nag-buster

### Installation

```
wget https://raw.githubusercontent.com/foundObjects/pve-nag-buster/master/install.sh
# Always read scripts downloaded from the internet before running them with sudo
chmod +x install.sh && sudo ./install.sh
```

Or via git:

```
git clone https://github.com/foundObjects/pve-nag-buster.git
cd pve-nag-buster && sudo ./install.sh
```

Removal:
```
./install.sh --uninstall
# remove /etc/apt/sources.list.d/pve-no-subscription.list if desired
```

### What is this? And why do I want it?

This is a dpkg post install hook script that persistently removes license nags
from Proxmox VE 5.x and up. Install it once and you won't see another license
nag until Proxmox changes the web-ui code significantly.

The included hook script removes the "unlicensed node" popup nag from the web
gui and disables the pve-enterprise repository list. This script is called
every time a package updates the web gui or the pve-enterprise source list and
will only run if packages containing those files are changed.

The installer drops the hook script, creates dpkg hooks to call it and adds the
pve-no-subscription repo list. There are no external dependencies beyond the
base packages installed with PVE by default (awk, sed, grep, wget).

For your convenience the install script also contains a base64 encoded copy of
pve-nag-buster.sh for use offline without access to github or a full clone of
the project. With a little text copy-pasting you can include pve-nag-buster
directly into your provisioning scripts for use during initial machine
provisioning at a stage where you might not have an outside network connection
available yet.

To inspect the base64 encoded script run `./install.sh --emit`; this dumps the
encoded copy to stdout and quits.  To install offline just run `sudo
./install.sh --offline`.

Thanks to John McLaren for his blog post documenting the web gui patch:

https://johnscs.com/remove-proxmox51-subscription-notice/

Please get in touch if you find a way to improve anything, otherwise enjoy!

#### Note:

Sorry to all 4 of you who've forked the repo before about 2020-01-10; I rewrote
git history to cleanup the commit noise from adding files through the web UI
initially. You should be able to rebase your own work on the "v02" tag without
issue once I push the 'rewrite' branch to master.
