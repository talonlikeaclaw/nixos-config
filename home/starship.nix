{ ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      character = {
        success_symbol = "[➜](bold green)";
      };
      package = {
        disabled = true;
      };
      line_break = {
        disabled = true;
      };
      custom = {
        coding_dir = {
          when = ''test "$PWD" = "$HOME/Code"'';
          command = ''echo ""'';
          format = "[$output]($style) ";
        };
      };
      directory = {
        truncate_to_repo = true;
        format = "[  $path]($style)[$read_only]($read_only_style) ";
      };
      git_branch = {
        format = "on [$branch]($style) ";
        style = "purple";
        symbol = " ";
      };
      git_status = {
        format = "([$all_status$ahead_behind]($style))";
        style = "red";
        conflicted = "🏳 ";
        ahead = "⇡ ";
        behind = "⇣ ";
        diverged = "⇕ ";
        up_to_date = "";
        untracked = " ";
        stashed = "⇄ ";
        modified = " ";
        staged = " ";
        renamed = " ";
        deleted = "✘ ";
      };
      hostname = {
        ssh_only = true;
        format = "[$hostname](bold yellow) ";
      };
      lua = {
        detect_folders = [ ];
      };
      nix_shell = {
        format = "via [$symbol$state]($style) ";
        symbol = "❄️ ";
      };
      nodejs = {
        format = "via [ $version](bold green) ";
      };
      python = {
        format = "via [ $version](bold blue) ";
        symbol = " ";
      };
      rust = {
        format = "via [ $version](bold red) ";
        symbol = " ";
      };
      username = {
        show_always = false;
        format = "[$user]($style) ";
      };
    };
  };
}

