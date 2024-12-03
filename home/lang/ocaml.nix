{ pkgs, ... }: {
  home.packages = with pkgs.ocamlPackages;
    [
      findlib
      ocaml
      ocaml-lsp
      # dune_3
      ocamlformat
      odoc
    ]
    ++ (with pkgs; [
      opam
      libev
      # pkg-config
      # openssl
    ]);
}
