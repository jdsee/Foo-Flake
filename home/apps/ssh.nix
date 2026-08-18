{ self, lib, ... }:
{
  home.file.".ssh" = {
    source = "${self}/secrets/ssh";
    recursive = true;
  };

  home.activation.sshSockets = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p -m 700 "$HOME/.ssh/sockets"
  '';
}
