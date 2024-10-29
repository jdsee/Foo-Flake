{ ... }:
{
  services.xremap = {
    enable = true;
    userName = "jdsee";
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
            # Esc = {
            #   alone = "Esc";
            #   held = {
            #     launch = "rofi -show pm -modi pm:rofi-power-menu";
            #   };
            #   alone_timeout_millis = 2000;
            # };
          };
        }
      ];
      keymap = [ ];
    };
  };
}
