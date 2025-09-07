{ pkgs, ... }: {
  imports = [
    ./atuin.nix
    ./git
    ./gpg.nix
    ./nushell.nix
    ./tmux
    ./tinker
    ./vim.nix
    ./zsh
  ];

  programs = {
    eza.enable = true;
    lazygit.enable = false;

    bat = {
      enable = true;
      config.theme = "base16";
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    yazi = {
      enable = false;
      enableZshIntegration = true;
      settings = {
        showHidden = true;
      };
    };
  };

  home = {
    sessionVariables = {
      EDITOR = "nvim";
    };

    packages = with pkgs; [
      file
      lsof
      inetutils

      fd # Better find
      httpie # Better curl
      hyperfine # Micro benchmark
      wget # File download
      jq # JSON pretty printer and manipulator
      yq-go # jq for yaml
      ncdu # TUI disk usage
      ripgrep # Better grep
      ripgrep-all # Better grep for everything
      colordiff # Colored diff
      restic # Backup tool
      bottom # Monitoring like htop
      lazydocker # Docker TUI
      openconnect # VPN
      pdftk # PDF utils
      steam-run # Emulate FHS file system
      tldr # Abbreviated man pages
      dust # More intuitive alternative to du
      rlwrap # Add history and easier navigation in line-reading programs
      nh # TODO: needed? -> Reimplementation of common nix-commands
      just # command runner
      claude-code # ai ¯\_(ツ)_/¯
      libimobiledevice
      ifuse
      git-crypt

      # compression
      p7zip
      unzip
      zip
    ];
  };
}
