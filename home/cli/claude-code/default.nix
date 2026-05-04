{ pkgs, ... }: {
  programs.claude-code = {
    enable = true;
    commands = {
      story = ./commands/story.md;
      bug = ./commands/bug.md;
    };
    context = ./context.md;
    # plugins = [
    #   pkgs.fetchFromGitHub
    #   {
    #     owner = "juliusbrussee";
    #     repo = "caveman";
    #     rev = "v1.6.0";
    #     sha256 = "228fdd7e5908ea1d2f65218ecd9c71e1eefa0834d200d55fbb8bf8b5563acec0";
    #   }
    # ];
  };
}
