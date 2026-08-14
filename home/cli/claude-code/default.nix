{ pkgs, ... }: {
  programs.claude-code = {
    enable = true;
    commands = {
      story = ./commands/story.md;
      bug = ./commands/bug.md;
    };
    context = ./context.md;
    settings = {
      DISABLE_TELEMETRY = 1;
    };
    plugins = {
      caveman = pkgs.fetchFromGitHub {
        owner = "juliusbrussee";
        repo = "caveman";
        rev = "v1.9.1";
        sha256 = "sha256-VqRHx3/4SSCnEh3cUJ/he5saIfwNhS0hOzoH/wwtU2o=";
      };
    };
  };
}
