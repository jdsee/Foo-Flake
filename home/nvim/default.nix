{ pkgs, ... }: {
  # TODO: Move Neovim config to separate flake

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      nvim-treesitter-parsers.nu
    ];

    viAlias = true;
    vimdiffAlias = true;

    withNodeJs = true;
    withPython3 = true;
  };

  home.packages = with pkgs; [
    dockerfile-language-server-nodejs
    elmPackages.elm-language-server
    kotlin-language-server
    lemminx
    lua-language-server
    marksman
    nil
    nixpkgs-fmt
    next-ls
    nodePackages_latest.bash-language-server
    nodePackages_latest.eslint
    nodePackages_latest.typescript-language-server
    ocamlPackages.ocaml-lsp
    postgres-lsp
    sqls
    tailwindcss-language-server
    texlab
    tree-sitter
    terraform-ls
    ruff
    pyright
    vscode-langservers-extracted # html/css/json/eslint
    yaml-language-server
  ];

  xdg.configFile = {
    nvim = {
      source = ./config/nvim;
      recursive = true;
    };
  };
}
