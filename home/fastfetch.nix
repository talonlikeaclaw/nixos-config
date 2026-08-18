{ dotfiles, ... }:

{
  xdg.configFile."fastfetch".source = "${dotfiles}/fastfetch/.config/fastfetch";
}
