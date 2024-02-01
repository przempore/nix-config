{ config, pkgs, pkgs-unstable, allowed-unfree-packages, ... }:
{
  imports = [
    ./kitty.nix
    (import ../../common/home { inherit config pkgs pkgs-unstable allowed-unfree-packages; })
  ];

  # Packages that should be installed to the user profile.
  home = {
    username = "przemek";
    homeDirectory = "/home/przemek";

    pointerCursor = {
      size = 8;
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
