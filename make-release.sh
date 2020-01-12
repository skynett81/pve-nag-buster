#!/bin/sh

_VERS="v03"

# I have no idea what I'm doing 🐶
#awk 'FNR==NR{s=(!s)?$0:s RS $0;next} /__BASE64__/{sub(/__BASE64__/, s)} 1' \
#  <(xz -z -9 -c pve-nag-buster.sh | base64) src/install > install.sh

# TODO: there's probably a two liner to handle all of this in awk
{
  head -n"$(grep -n "<< 'YEET'" install.sh | cut -d: -f1)" install.sh
  xz -z -9 -c pve-nag-buster.sh | base64
  tail -n+"$(grep -n '^YEET$' install.sh | cut -d: -f1)" install.sh
} > foofile
cat foofile > install.sh
rm -f foofile

sed -i -e "s/([v[[:digit:]][[:digit:]])/($_VERS)/" pve-nag-buster.sh install.sh
