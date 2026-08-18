{ dotfiles, ... }:

{
  xdg.configFile."television".source = "${dotfiles}/television/.config/television";
}
