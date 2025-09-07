# My NixOS and Home-Manager configuration

This repository contains the configuration of my personal computer with [Nix](https://nixos.wiki/wiki/Nix_package_manager), [NixOS](https://nixos.wiki/wiki/Overview_of_the_NixOS_Linux_distribution) and [Home-Manager](https://nixos.wiki/wiki/Home_Manager).

Feel free to use whatever you need but be aware that I'm still in the process of learning and things might not be implemented in an ideal way.

## Structure of this repository

This is my second attempt of a NixOS and Home-Manager configuration.
I will try to keep this a bit simpler then the [previous one](https://github.com/jdsee/nix-config).
I started with a single user and host configuration and wanna see how far I get with just that, before making the configuration more complex.

The following shows the current file structure:
```
mynix
│
├── home            # Everything that belongs into $XDG_HOME (Home-Manager)
│   ├── apps        # GUI applications
│   ├── cli         # CLI setup and command line applications
│   ├── desktop     # Desktop setup and Desktop Utilities
│   └── neovim      # Beloved $EDITOR
│
├── host            # System wide configuration
│   ├── services    # System services
│   └── users       # System users (links to ./home/<username>.nix)
│
└── overlays        # Customization of packages
```

## How to run

This configuration can either be used with NixOS or Home-Manager on any other distribution with Nix installed.

**Use config under NixOS**
```bash
sudo nixos-rebuild switch --flake ~/mynix#saxum
```

**User config with Home-Manager**
```bash
sudo nixos-rebuild switch --flake ~/mynix#saxum
```

## Credits

Most of the things I know about Nix, I learned through examples and explanations of others. I really appreciate them taking the time to write that stuff down to make it easier for me to understand, use and love Nix.

The following is a list of people and resources that helped me a lot in configuring my system. I try to add links to the places I took inspiration / stole configuration from. Still there's a bunch of older stuff, of which i can't recall where i have it from. Thanks to anyone sharing their knowledge!

- [Misterio77](https://github.com/Misterio77)'s [nix-config](https://github.com/Misterio77/nix-config) - Great resource to get started with NixOS and Home-Manager.
- [Starter config](https://github.com/Misterio77/nix-starter-configs) for a cool starting point if you're interesetd in [Nix](https://nixos.wiki/wiki/Nix_package_manager)
- [tjdevries](https://github.com/tjdevries) - Lot's of cool Neovim stuff

## References

- [NixOS](https://nixos.org/)
- [Home Manager](https://nixos.wiki/wiki/Home_Manager)
- [Nix Flakes](https://nixos.wiki/wiki/Flakes)
- [Zero-to-Nix](https://zero-to-nix.com/concepts/flakes) - Straight forward introduction to Nix-Flakes.
