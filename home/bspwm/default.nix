{ config, pkgs, ... }:
{

  home.file.".config/bspwm/wallpapers" = {
    source = ./wallpapers;
  };

  xsession.windowManager.bspwm = {
    enable = true;
    extraConfigEarly = ''
      if [ -e ~/.screenlayout/script.sh ]; then
        ~/.screenlayout/script.sh
      fi

      bspc config border_width         2
      bspc config window_gap           4
      bspc config top_padding          30
      bspc config bottom_padding       4
      bspc config left_padding         4
      bspc config right_padding        4
      bspc config single_monocle       false
      bspc config split_ratio          0.50
      bspc config borderless_monocle   true
      bspc config gapless_monocle      true
      bspc config focus_follows_pointer true
      bspc config pointer_modifier mod4
      bspc config pointer_action1 move
      bspc config pointer_action2 resize_side
      bspc config pointer_action3 resize_corner
      bspc config remove_disabled_monitors true
      bspc config merge_overlapping_monitors true

#BSPWM coloring
      bspc config normal_border_color	"#4c566a"
      bspc config active_border_color	"#1e1e1e"
      bspc config focused_border_color	"#5e81ac"
      bspc config presel_feedback_color	"#5e81ac"

#Single monitor
      bspc monitor -d 1 2 3 4 5 6 7 8 9 10
      '';
    extraConfig = ''
      function get_location {
          location=$(curl -s "https://location.services.mozilla.com/v1/geolocate?key=geoclue" | jq -r '"\(.location.lat):\(.location.lng)"')
          if [ -z $location ]; then
              location="52.5196:13.4069"
              echo "[bspwm autostart] no internet connection, setting location to Berlin [$location" | systemd-cat
          fi
          echo "[bspwm autostart] location for redshift: $location" | systemd-cat
      }

      polybar mainbar 2>/dev/null &
      feh --bg-scale $HOME/.dotfiles/variety/.config/variety/Favorites/6gz4757ztdx91.jpg
      keepassxc &
      blueberry-tray &
      clipster -d &
      nm-applet &
      get_location
      redshift -l $location &
      '';
  };
}
