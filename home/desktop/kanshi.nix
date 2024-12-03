{ ... }: {
  services.kanshi = {
    enable = true;
    systemdTarget = "graphical-session.target";
    settings = [
      {
        profile = {
          name = "mobile";
          outputs = [
            {
              criteria = "eDP-1";
              status = "enable";
            }
          ];
          exec = [
            ''
              notify-send "Activated display profile 'mobile'"
            ''
          ];
        };
      }
      {
        profile = {
          name = "home";
          outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
            }
            {
              criteria = "Dell Inc. DELL P2719H J9T8193";
              position = "0,0";
              transform = "90";
            }
            {
              criteria = "Dell Inc. DELL U3219Q 8P7R413";
              position = "1080,0";
            }
          ];
          exec = [
            ''
              notify-send "Activated display profile 'home'"
            ''
          ];
        };
      }
    ];
  };
}
