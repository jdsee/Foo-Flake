alias s := switch

default: switch

switch:
  sudo -v && nixos-rebuild switch --flake ~/foo-flake#saxum --sudo

hm-conflict:
  journalctl -xe --unit home-manager-jdsee.service | grep --color -iE "in the way|existing file '[^']+'"
