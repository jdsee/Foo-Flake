{ ... }: {
  services.displayManager = {
    # defaultSession = "river";
    sddm = {
      wayland.enable = true;
    };
  };
}
