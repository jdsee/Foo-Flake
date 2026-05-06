{ ... }:
{
  services.espanso = {
    enable = true;

    configs = {
      default = {
        toggle_key = "OFF";
        search_shortcut = "ALT+SHIFT+ENTER";
      };
    };

    matches = {
      umlauts-symbol = {
        matches = [
          { trigger = ";a"; replace = "ä"; }
          { trigger = ";o"; replace = "ö"; }
          { trigger = ";u"; replace = "ü"; }
          { trigger = ";A"; replace = "Ä"; }
          { trigger = ";O"; replace = "Ö"; }
          { trigger = ";U"; replace = "Ü"; }
          { trigger = ";s"; replace = "ß"; }
          { trigger = ";z"; replace = "ß"; }
        ];
      };
      umlauts-spelled = {
        matches = [
          { trigger = "aee"; replace = "ä"; }
          { trigger = "oee"; replace = "ö"; }
          { trigger = "uee"; replace = "ü"; }
          { trigger = "Aee"; replace = "Ä"; }
          { trigger = "Oee"; replace = "Ö"; }
          { trigger = "Uee"; replace = "Ü"; }
          { trigger = "sse"; replace = "ß"; }
        ];
      };
    };
  };
}
