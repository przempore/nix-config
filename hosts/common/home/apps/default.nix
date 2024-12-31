{ pkgs, zen-browser, ghostty, ... }:
{
  home.packages = [
    zen-browser.packages.x86_64-linux.default
    ghostty.packages.x86_64-linux.default
  ]
  ++ (with pkgs; [
    any-nix-shell
    autojump
    eza
    fzf # A command-line fuzzy finder
    ripgrep
    fastfetch
    yazi
    sshfs
    discord
    ncpamixer
  ]);

  imports = [
    ./direnv.nix
    ./firefox.nix
    ./fish.nix
    ./git.nix
    ./kitty
    ./mpv.nix
    ./nvim
    ./ranger.nix
    ./starship.nix
    ./tmux.nix
    ./wezterm
    ./zathura.nix
  ];
}
