{ ... }: {
  programs.claude-code = {
    enable = true;
    commands = {
      story = ./commands/story.md;
      bug = ./commands/bug.md;
    };
    context = ./context.md;
  };
}
