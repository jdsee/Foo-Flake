{ pkgs, ... }:

{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-surround
    ];
    settings = {
      number = true;
      relativenumber = true;
      ignorecase = true;
      hidden = true;
      tabstop = 2;
      expandtab = true;
    };
  };
}
