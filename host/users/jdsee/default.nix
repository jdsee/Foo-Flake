{ pkgs
, config
, ...
}:
let
  user = "jdsee";
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users = {
    mutableUsers = true;
    users.${user} = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups =
        [
          "audio"
          "camera"
          "input"
          "jackaudio"
          "uinput"
          "video"
          "wheel"
        ]
        ++ ifTheyExist [
          "plugdev"
          "deluge"
          "docker"
          "git"
          "i2c"
          "libvirtd"
          "network"
          "networkManager"
        ];

      packages = [ pkgs.home-manager ];
    };
  };

  home-manager.users.${user} = import ./home/${config.networking.hostName}.nix;

  users.groups.uinput = { };

  services.udev.extraRules = ''
    # Required by Kanata
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  services.geoclue2.enable = true;
}
