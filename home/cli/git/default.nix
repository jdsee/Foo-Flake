{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "jdsee";
    userEmail = "joscha.seelig@.linked-planet.com";
    lfs.enable = true;
    hooks = {
      # prepare-commit-msg = ./hooks/prepare-commit-msg;
    };
    aliases = {
      last = "log -n 1 --stat";
      aa = "add --all";
      cp = "cherry-pick";
      co = "checkout";
      cl = "clone";
      ci = "commit";
      cane = "commit --amend --no-edit";
      s = "status";
      fp = "push --force";
      fl = "push --force-with-lease";
      br = "branch";
      unstage = "reset HEAD - -";
      dc = "diff --cached";
      lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
      res = "!git fetch && git reset origin/`git rev-parse --abbrev-ref HEAD` --hard";
      lh = "!git log --oneline -n 15";
      graph = ''log --graph --color --pretty=format:"%C (yellow)%H%C (green)%d%C (reset)%n%x20%cd%n%x20%cn%x20 (%ce)%n%x20%s%n "'';
      tags = "tag - l"; # Show verbose output about tags, branches or remotes;
      branches = "branch - a";
      remotes = "remote - v";
      amend = "commit --amend --reuse-message=HEAD"; # Amend the currently staged files to the latest commit;
      contributors = "shortlog --summary --numbered"; # List contributors with number of commits;
      alias = "!git config - l | grep ^alias | cut - c 7 - | sort";
      ir = "rebase -i --autostash";
      pwt = "push --atomic origin"; # Push branch and tag simultaneously: git pwt <branch> <tag>
      ps = "pull --autostash";
      conflicts = "!grep -lr '<<<<<<<' .";
      clone-multibranch = "!sh ~/.config/git/clone_bare_for_worktrees.sh";
      rebase-last = "!git rebase --interactive --autostash HEAD~$1";
    };
    extraConfig = {
      core.editor = "nvim";
      color.ui = true;
      init.defaultBranch = "main";
      log.decorate = true;
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
      user.signingKey = "F15E366F8518E709";
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

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
      hosts = [ "https://github.com" ];
    };
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



