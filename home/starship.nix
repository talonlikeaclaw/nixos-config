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
          command = ''echo "📁"'';
          format = "[$output]($style) ";
        };
      };
      directory = {
        truncation_length = 0;
        truncate_to_repo = false;
      };
      lua = {
        detect_folders = [];
      };
    };
  };
}