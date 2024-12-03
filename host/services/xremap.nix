{ ... }: {
  systemd.user.services.xremap.wantedBy = [ "river-session.target" ];
  services.xremap = {
    enable = true;
    userName = "jdsee";
    withWlroots = true;
    config = {
      modmap = [
        {
          name = "Custom Keymap";
          remap = {
            CapsLock = {
              held = "Control_L";
              alone = "Esc";
              alone_timeout_millis = 420;
            };
            Control_L = {
              held = "Control_L";
              alone = "Esc";
              alone_timeout_millis = 420;
            };
          };
        }
      ];
      keymap = [
        # {
        #   name = "Umlauts";
        #   remap = {
        #     KEY_A.timeout_millis = 200;
        #     KEY_A.remap.KEY_E.remap.KEY_UP = { };
        #   };
        # }
      ];
    };
  };
}
