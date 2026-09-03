{ pkgs, config, ... }:

let
  kotlin-lsp = pkgs.callPackage ./kotlin-lsp.nix { };
in
{
  # TODO: Move Neovim config to separate flake

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    # Temporarily use stable neovim due to build issue with nightly overlay
    # package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;

    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      nvim-treesitter-parsers.nu
      blink-cmp
    ];

    viAlias = true;
    vimdiffAlias = true;

    withNodeJs = true;
    withPython3 = true;
    withRuby = false;
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
    bash-language-server
    eslint
    typescript-language-server
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
    kotlin-lsp
  ];

  xdg.configFile = {
    nvim = {
      source = ./config/nvim;
      recursive = true;
    };

    # Keep lazy-lock.json writable and tracked in the flake working tree so
    # `:Lazy sync`/`:Lazy update` write through to it directly.
    "nvim/lazy-lock.json".source =
      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/foo-flake/home/nvim/config/nvim/lazy-lock.json";
  };
}
