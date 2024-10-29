{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = false; # leads to bugs when enabled - zplug already calls compinit
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    defaultKeymap = "emacs";

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
    ];

    zplug = {
      enable = true;
      plugins = [
        { name = "mafredri/zsh-async"; }
        { name = "sindresorhus/pure"; }
        { name = "jdsee/popman"; }
      ];
    };

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
    };

    profileExtra = ''
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
        . $HOME/.nix-profile/etc/profile.d/nix.sh
      fi

      export LAUNCHER=launcher_t4
    '';

    initExtra = ''
      gpg-connect-agent updatestartuptty /bye > /dev/null

      # helper to make modifiable copy of immutable link to nix store
      function tinker() {
        FILE=$1
        mv $1 $1.bak
        cp $1.bak $1
        chmod +w $1
        vi $1
      }

      # generate gitignore file
      # i.e.: `ignore ocaml linux macos`
      function ignore() {
        local IFS=,
        curl "https://www.toptal.com/developers/gitignore/api/$*" >> .gitignore
      }

      export PATH="$PATH:$HOME/bin:$HOME/.config/rofi/scripts:$HOME/.cargo/bin";

      export BUN_INSTALL="$HOME/.bun"
      export PATH="$BUN_INSTALL/bin:$PATH"
      [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

      bindkey '^O' autosuggest-accept

      # Tmux Sessionizer
      run_tmux_sessionizer() {
        ~/.config/tmux/tmux-sessionizer.sh
      }
      zle -N run_tmux_sessionizer
      bindkey '^G' run_tmux_sessionizer

      # Helper functions for gpg en-/decryption
      secret () {
        output=~/"$1".$(date +%s).enc
        gpg --encrypt --armor --output $output \
          -r $KEYID "$1" && echo "$1 -> $output"
      }

      reveal () {
        output=$(echo "$1" | rev | cut -c16- | rev)
        gpg --decrypt --output $output "$1" && \
          echo "$1 -> $output"
      }

      pw () {
        gopass ls -f | fzf | xargs gopass -c
      }

      ###-begin-index.js-completions-###
      _index.js_yargs_completions()
      {
        local reply
        local si=$IFS
        IFS=$'
      ' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" .//nix/store/gyy4m0g1hvz4nvi4jn27hjz54zfnqfyj-gitlab-ci-local-4.52.0/lib/node_modules/gitlab-ci-local/src/index.js --get-yargs-completions "''${words[@]}"))
        IFS=$si
        _describe 'values' reply
      }
      compdef _index.js_yargs_completions index.js
      ###-end-index.js-completions-###

      #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
      [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
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

      _ = "sudo";
      cat = "bat -p";
      grep = "grep --color";
      hg = "history 0 | grep";
      diff = "colordiff";

      cbc = "xclip -sel clip";
      cbp = "xclip -o -sel clip";

      mux = "tmuxinator";

      htwconnect = "rbw get account.htw-berlin.de | sudo openconnect --protocol anyconnect --passwd-on-stdin --user=s0566845@htw-berlin.de --authgroup=HTW-SSL-VPN-Full https://vpncl.htw-berlin.de";
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

  home.packages = with pkgs; [
    gitlab-ci-local
  ];
}
