{ pkgs, ... }: {
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "jdsee";
    userEmail = "joscha.seelig@linked-planet.com";
    lfs.enable = true;
    hooks = {
      # prepare-commit-msg = ./hooks/prepare-commit-msg;
    };
    aliases = {
      # general
      aa = "add --all";
      s = "status";
      sw = "switch";
      mt = "mergetool";
      unstage = "reset HEAD - -";
      dc = "diff --cached";
      alias = "!git config - l | grep ^alias | cut - c 7 - | sort";
      bi = "bisect";

      # push / pull
      p = "push";
      pl = "pull";
      plr = "push --rebase";
      fp = "push --force";
      fl = "push --force-with-lease";
      pwt = "push --atomic origin"; # Push branch and tag simultaneously: git pwt <branch> <tag>

      # commit
      c = "commit";
      cane = "commit --amend --no-edit";
      wip = "!git commit -m \"[WIP] $(curl -s https://whatthecommit.com/index.txt)\"";

      # rebase
      rb = "rebase";
      rba = "rebase --abort";
      rbc = "rebase --continue";
      rbs = "rebase --skip";
      rbi = "rebase --interactive";

      # cherry-pick
      cp = "cherry-pick";
      co = "checkout";
      cl = "clone";

      # branch
      br = "branch";

      # worktree
      wt = "worktree";
      clone-multibranch = "!sh ~/.config/git/clone_bare_for_worktrees.sh";

      # log
      l = "log --oneline";
      lh = "log --oneline -n 15";
      last = "log -n 1 --stat";
      lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
      res = "!git fetch && git reset origin/`git rev-parse --abbrev-ref HEAD` --hard";
      graph = ''log --graph --color --pretty=format:"%C (yellow)%H%C (green)%d%C (reset)%n%x20%cd%n%x20%cn%x20 (%ce)%n%x20%s%n "'';

      # tag
      inc-patch = ''
        !git tag --list --sort v:refname | tail -n 1 | awk -F. '{ print $1 "." $2 "." ($3 + 1) }' | xargs -p -I _ sh -c 'git tag _ -m _ && git push && git push origin _'
      '';
      inc-minor = ''
        !git tag --list --sort v:refname | tail -n 1 | awk -F. '{ print $1 "." ($2 + 1) ".0" }' | xargs -p -I _ sh -c 'git tag _ -m _ && git push && git push origin _'
      '';
      inc-major = ''
        !git tag --list --sort v:refname | tail -n 1 | awk -F. '{ print ($1 + 1) ".0.0" }' | xargs -p -I _ sh -c 'git tag _ -m _ && git push && git push origin _'
      '';

      # list
      branches = "branch - a";
      remotes = "remote - v";
      tags = "tag - l"; # Show verbose output about tags, branches or remotes;
      conflicts = "!grep -lr '<<<<<<<' .";
      contributors = "shortlog --summary --numbered"; # List contributors with number of commits;
    };
    extraConfig = {
      core.editor = "nvim";
      color.ui = true;
      init.defaultBranch = "main";
      log.decorate = true;
      merge.tool = "nvimdiff";
      mergetool = {
        nvimdiff.cmd = "nvim -c 'G mergetool' -c 'Gvdiffsplit!'";
        keepBackup = false;
      };
      push = {
        autoSetupRemote = true;
        # gpgSign = "if-asked";
      };
      pull = {
        ff = "only";
        rebase = true;
      };
      help = {
        autoCorrect = 0;
      };
      user.signingKey = "2B401F46E5C119E1";
      commit.gpgSign = true;
      tag.gpgSign = true;
      rebase.autoStash = true;
    };

    ignores = [
      ".DS_Store"
      "*.pyc"
    ];

    difftastic = {
      enable = true;
      display = "side-by-side"; # one of "side-by-side", "side-by-side-show-both", "inline"
    };

    diff-so-fancy = {
      enable = false;
    };

    delta = {
      enable = false;
      options = {
        navigate = true;
        line-numbers = true;
        syntax-theme = "DarkNeon";
      };
    };
  };

  home.packages = with pkgs; [
    glab
  ];

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
      hosts = [ "https://github.com" ];
    };
    extensions = with pkgs; [
      gh-copilot
    ];
  };

  programs.gh-dash = {
    enable = true;
  };

  programs.gitui = {
    enable = true;
    keyConfig = builtins.readFile ./gitui_vim_keys.ron;
    theme = builtins.readFile ./gitui_theme.ron;
  };

  xdg.configFile."git/clone_bare_for_worktrees.sh" = {
    source = ./clone_bare_for_worktrees.sh;
    executable = true;
  };
}
