{ pkgs, ... }:
{
  programs.wezterm = {
    enable = true;
  };
  home.file.".wezterm.lua".source = ./wezterm.lua;
}
