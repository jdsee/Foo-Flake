{ pkgs, config, ... }:
{

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
      ];
    };

    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      open = false;
      nvidiaSettings = true;
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = false;
      };
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
}
