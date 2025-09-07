{ pkgs
, lib
, ...
}:
let
  popman_repo = pkgs.fetchFromGitHub {
    owner = "jdsee";
    repo = "popman";
    rev = "v0.1.0";
    sha256 = "YEJ1BCKXVlbSTwssj1r1ld5Kc6znxxoJ80A3Zniy6Mo=";
  };
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = false; # slows down session start when enabled
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    defaultKeymap = "viins";

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
      {
        name = pkgs.pure-prompt.pname;
        src = pkgs.pure-prompt.src;
      }
      {
        name = pkgs.zsh-vi-mode.pname;
        src = pkgs.zsh-vi-mode.src;
      }
      {
        name = pkgs.zsh-autopair.pname;
        src = pkgs.zsh-autopair.src;
      }
      {
        name = "custom-functions";
        src = ./functions;
      }
    ];

    history = {
      size = 100000;
      save = 1000000;
      share = true;
      expireDuplicatesFirst = true;
      ignoreSpace = true;
    };

    sessionVariables = {
      PATH = "$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.config/rofi/scripts";
      GPG_TTY = "$(tty)";
      SSH_AUTH_SOCK = "$(gpgconf --list-dirs agent-ssh-socket)";
      MANPAGER = "nvim +Man!";
      PURE_NODE_ENABLED = 0;
      PURE_CMD_MAX_EXEC_TIME = 1;
      LAUNCHER = "launcher_t4";
      GOTELEMETRY = "off";
    };

    profileExtra = ''
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
        . $HOME/.nix-profile/etc/profile.d/nix.sh
      fi
      if [ -z "$WAYLAND_DISPLAY" ] && [ $(tty) = "/dev/tty1" ]; then
        exec river
      fi
    '';

    initContent = ''
      autoload -U promptinit; promptinit
      prompt pure

      gpg-connect-agent updatestartuptty /bye > /dev/null

      export PATH="$PATH:$HOME/bin:$HOME/.config/rofi/scripts:$HOME/.cargo/bin";

      # Tmux Sessionizer
      run_tmux_sessionizer() {
        ~/.config/tmux/tmux-sessionizer.sh
      }
      zle -N run_tmux_sessionizer
      bindkey -M emacs '^G' run_tmux_sessionizer
      bindkey -M viins '^G' run_tmux_sessionizer

      # Autosuggest
      bindkey -M emacs '^O' autosuggest-accept
      bindkey -M viins '^O' autosuggest-accept
      bindkey -M vicmd '^O' autosuggest-accept

      # Claude popup
      open_claude_popup() {
        tmux display-popup -d "#{pane_current_path}" claude
      }
      zle -N open_claude_popup
      bindkey -M emacs '^B' open_claude_popup
      bindkey -M viins '^B' open_claude_popup
      bindkey -M vicmd '^B' open_claude_popup

      # Atuin
      if command -v atuin &> /dev/null; then
        # Delay Atuin init until after zsh-vi-mode init to prevent overwriting of keybinds
        zvm_after_init_commands+=(eval "$(${lib.getExe pkgs.atuin} init zsh --disable-up-arrow)")
      fi

      # Popman - Initialize after zsh-vi-mode to prevent keybinding conflicts
      zvm_after_init_commands+=('source ${popman_repo}/popman.plugin.zsh')

      # TODO: These functionsb are not loaded somehow
      # fpath+="$XDG_CONFIG_HOME/zsh/functions"
      # $XDG_CONFIG_HOME/zsh/functions/init.zsh

      # -------------------------------------
      # ↓ Generated ↓
      # -------------------------------------

      # BUN
      export BUN_INSTALL="$HOME/.bun"
      export PATH="$BUN_INSTALL/bin:$PATH"
      [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
    '';

    shellAliases = {
      vind = "nvim -c 'Telescope zoxide list'";
      vile = "nvim -c 'Telescope find_files'";
      fls = "nvim -c Oil";
      oil = "nvim -c Oil";

      ls = "exa";
      ll = "ls -alh";
      la = "ls -a";
      ld = "ls -ad";
      tree = "la --tree";
      trees = "tree --depth 4";

      ".." = "cd ../";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      "....." = "cd ../../../../";
      "......" = "cd ../../../../../";

      lzg = "lazygit";
      lzd = "lazydocker";
      rmgi = "git rm -r --cached . && git add . && git status";

      cat = "bat -p";
      grep = "grep --color";
      hg = "history 0 | grep";
      diff = "colordiff";

      cbc = "xclip -sel clip";
      cbp = "xclip -o -sel clip";

      mux = "tmuxinator";

      img = "qimgv";
      ed = "zeditor";

      tt = "toggle-theme";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    tmux.enableShellIntegration = false;
  };

  programs.bat = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd j"
    ];
  };

  xdg = {
    configFile = {
      "zsh/functions" = {
        source = ./functions;
        recursive = true;
      };
    };
  };
}
