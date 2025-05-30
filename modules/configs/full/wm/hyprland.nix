{ ... }:
let
  flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";

  hyprland =
    (import flake-compat {
      src = builtins.fetchTarball "https://github.com/hyprwm/Hyprland/archive/287f313.tar.gz";
    }).defaultNix;
in
{
  imports = [
    hyprland.homeManagerModules.default
  ];

  wayland.windowManager.hyprland.enable = true;
}
