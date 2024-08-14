{ config, ... }:
let
  link = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.file = {
    ".config/nixpkgs/config.nix".source                   = link ./config.nix;
    ".config/nixpkgs/config.nix".force                    = true;

    ".config/gromit-mpx.ini".source                       = link ./gromit-mpx.ini;
    ".config/gromit-mpx.ini".force                        = true;

    ".config/flameshot".source                            = link ./flameshot;
    ".config/flameshot".force                             = true;

    ".config/fish".source                                 = link ./fish;
    ".config/fish".force                                  = true;

    ".config/xplr".source                                 = link ./xplr;
    ".config/xplr".force                                  = true;

    ".config/mpv/scripts".source                          = link ./mpv/scripts;
    ".config/mpv/scripts".force                           = true;

    ".config/mpv/script-opts/youtube-quality.conf".source = link ./mpv/youtube-quality.conf;
    ".config/mpv/script-opts/youtube-quality.conf".force  = true;

    ".config/starship.toml".source                        = link ./starship.toml;
    ".config/starship.toml".force                         = true;

    ".config/default.png".source                          = link ./default.png;
    ".config/default.png".force                           = true;

    ".config/htop".source                                 = link ./htop;
    ".config/htop".force                                  = true;

    ".config/clipit".source                               = link ./clipit;
    ".config/clipit".force                                = true;

    ".config/kitty/kitty.conf".source                     = link ./kitty.conf;
    ".config/kitty/kitty.conf".force                      = true;

    ".icons".source                                       = link ./icons;
    ".icons".force                                        = true;

    ".xinitrc".source                                     = link ./xinitrc;
    ".xinitrc".force                                      = true;

    ".bashrc".source                                      = link ./bashrc;
    ".bashrc".force                                       = true;

    ".Xresources".source                                  = link ./Xresources;
    ".Xresources".force                                   = true;
  };
}

