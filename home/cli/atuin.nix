{ ... }:
{
  programs.atuin = {
    enable = true;

    # HACK:
    # Atuin keybinds are overridden by zsh-vi-mode.
    # For now I'm setting up ZSH-Integration manually in zsh/default.nix.
    # Should be fixed at some point with https://github.com/atuinsh/atuin/issues/1826
    enableZshIntegration = false;

    flags = [ "--disable-up-arrow" ];
    settings = {
      keymap_mode = "auto";
      style = "compact";
      inline_height = 20;
      invert = true;
      show_preview = true;
      show_help = false;
    };
  };
}
