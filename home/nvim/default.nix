{ pkgs, inputs, ... }:
let
  kotlin-lsp = pkgs.callPackage ./kotlin-lsp.nix { };
in
{
  # TODO: Move Neovim config to separate flake

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;

    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      nvim-treesitter-parsers.nu
      blink-cmp
    ];

    viAlias = true;
    vimdiffAlias = true;

    withNodeJs = true;
    withPython3 = true;
  };

  home.packages = with pkgs; [
    dockerfile-language-server
    docker-compose-language-service
    elmPackages.elm-language-server
    gopls
    lemminx
    lua-language-server
    marksman
    helm-ls
    nil
    nixpkgs-fmt
    next-ls
    nodePackages_latest.bash-language-server
    nodePackages_latest.eslint
    nodePackages_latest.typescript-language-server
    ocamlPackages.ocaml-lsp
    postgres-language-server
    sqls
    tailwindcss-language-server
    texlab
    tree-sitter
    terraform-ls
    ruff
    pyright
    vscode-langservers-extracted # html/css/json/eslint
    yaml-language-server
    zls
    kotlin-language-server
  ] ++ [
    # kotlin-lsp
  ];

  xdg.configFile = {
    nvim = {
      source = ./config/nvim;
      recursive = true;
    };
  };
}
