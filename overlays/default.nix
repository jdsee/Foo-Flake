{ inputs, ... }: {
  # Makes packages from the stable channel available with `pkgs.stable`
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  };

  modifications = final: prev: {
    # EXAMPLE:
    #
    # <modified-pkg> = prev.<pkg>.overrideAttrs (old: rec {
    #   version = "4.20";
    #   src = final.fetchFromGitHub {
    #     owner = "<pkg>";
    #     repo = "<pkg>";
    #     rev = version;
    #     sha256 = "sha256-jkGcaghCP4oqw280pLt9XCJEZDZvb9o1sK0grdy/D7s=";
    #   };
    # });

    jetbrains = prev.jetbrains // {
      idea-ultimate = prev.jetbrains.idea-ultimate.overrideAttrs (oldAttrs: rec {
        version = "2025.1.6";
        src = final.fetchurl {
          url = "https://download.jetbrains.com/idea/ideaIU-${version}.tar.gz";
          sha256 = "sha256-ndvgYQ2rikg/ShLd5YfZBsp//Tme7585X77b2Noxg0U=";
        };
      });
    };

    tmux-31c = prev.tmux.overrideAttrs (old: rec {
      version = "3.1c";
      patches = [ ];
      src = final.fetchFromGitHub {
        owner = "tmux";
        repo = "tmux";
        rev = version;
        sha256 = "sha256-jkGcaghCP4oqw280pLt9XCJEZDZvb9o1sK0grdy/D7s=";
      };
    });

    # flameshot-grim = prev.flameshot.overrideAttrs (oldAttrs: {
    #   src = final.fetchFromGitHub {
    #     owner = "flameshot-org";
    #     repo = "flameshot";
    #     rev = "v12.1.0";
    #     sha256 = "sha256-omyMN8d+g1uYsEw41KmpJCwOmVWLokEfbW19vIvG79w=";
    #   };
    #   cmakeFlags = [
    #     "-DUSE_WAYLAND_CLIPBOARD=1"
    #     "-DUSE_WAYLAND_GRIM=1"
    #   ];
    #   buildInputs = oldAttrs.buildInputs ++ [ final.libsForQt5.kguiaddons ];
    # });

  };
}
