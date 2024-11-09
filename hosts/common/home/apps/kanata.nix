{ pkgs, lib, config, ... }: {
  services.kanata = {
    enable = true;
    keyboards = {
      "default" = {
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          ;; Home row mods QWERTY example with more complexity.
          ;; Some of the changes from the basic example:
          ;; - when a home row mod activates tap, the home row mods are disabled
          ;;   while continuing to type rapidly
          ;; - tap-hold-release helps make the hold action more responsive
          ;; - pressing another key on the same half of the keyboard
          ;;   as the home row mod will activate an early tap action

          (defsrc
            caps a   s   d   f   j   k   l   ;
          )
          (defvar
            ;; Note: consider using different time values for your different fingers.
            ;; For example, your pinkies might be slower to release keys and index
            ;; fingers faster.
            tap-time 300
            hold-time 150

            left-hand-keys (
              q w e r t
              a s d f g
              z x c v b
            )
            right-hand-keys (
              y u i o p
              h j k l ;
              n m , . /
            )
          )
          (deflayer base
            @cec @a  @s  @d  @f  @j  @k  @l  @;
          )

          (deflayer nomods
            esc a   s   d   f   j   k   l   ;
          )
          (deffakekeys
            to-base (layer-switch base)
          )
          (defalias
            tap (multi
              (layer-switch nomods)
              (on-idle-fakekey to-base tap 20)
            )

            cec (tap-hold 200 200 esc lctl)

            a (tap-hold-release-keys $tap-time $hold-time (multi a @tap) lmet $left-hand-keys)
            s (tap-hold-release-keys $tap-time $hold-time (multi s @tap) lalt $left-hand-keys)
            d (tap-hold-release-keys $tap-time $hold-time (multi d @tap) lctl $left-hand-keys)
            f (tap-hold-release-keys $tap-time $hold-time (multi f @tap) lsft $left-hand-keys)
            j (tap-hold-release-keys $tap-time $hold-time (multi j @tap) rsft $right-hand-keys)
            k (tap-hold-release-keys $tap-time $hold-time (multi k @tap) rctl $right-hand-keys)
            l (tap-hold-release-keys $tap-time $hold-time (multi l @tap) ralt $right-hand-keys)
            ; (tap-hold-release-keys $tap-time $hold-time (multi ; @tap) rmet $right-hand-keys)
          )
        '';
      };
    };
  };
}
