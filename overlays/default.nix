{ inputs, ... }:
{
  # Makes packages from the stable channel available with `pkgs.stable`
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
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

    flameshot-grim = prev.flameshot.overrideAttrs (oldAttrs: {
      src = final.fetchFromGitHub {
        owner = "flameshot-org";
        repo = "flameshot";
        rev = "3d21e4967b68e9ce80fb2238857aa1bf12c7b905";
        sha256 = "sha256-OLRtF/yjHDN+sIbgilBZ6sBZ3FO6K533kFC1L2peugc=";
      };
      cmakeFlags = [
        "-DUSE_WAYLAND_CLIPBOARD=1"
        "-DUSE_WAYLAND_GRIM=1"
      ];
      buildInputs = oldAttrs.buildInputs ++ [ final.libsForQt5.kguiaddons ];
    });
  };
}
