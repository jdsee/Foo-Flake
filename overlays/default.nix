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

  };
}
