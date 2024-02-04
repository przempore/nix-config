{ config, pkgs, pkgs-unstable, allowed-unfree-packages, ... }:

{
  imports = [
    ../../common/home
    ../../common/home/desktop
    ../../common/home/apps/teleport.nix
    ../../common/home/apps/google-cloud.nix
  ];

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  home = {
    username = "porebski";
    homeDirectory = "/home/porebski";

    # set rdp_use_client_keymap=1 in ~/.config/remmina/remmina.pref
    packages = with pkgs; [
      remmina
      dbeaver
    ];
  };
}
