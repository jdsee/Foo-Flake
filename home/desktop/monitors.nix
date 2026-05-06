{ lib, ... }:
{
  options = {
    monitors = {
      primary = lib.mkOption {
        type = lib.types.str;
        default = "Dell Inc. DELL U3219Q 8P7R413";
        description = "Primary monitor identifier";
      };
      secondary = lib.mkOption {
        type = lib.types.str;
        default = "Dell Inc. DELL P2719H J9T8193";
        description = "Secondary monitor identifier";
      };
    };
  };

  config = {
    monitors = {
      primary = "Dell Inc. DELL U3219Q 8P7R413";
      secondary = "Dell Inc. DELL P2719H J9T8193";
    };
  };
}
