{ pkgs, ... }:
#using unstable means regular updates, ie more data usage
let
  google-chrome =
    (pkgs.google-chrome.override {
      commandLineArgs = [
        #"--enable-features=UseOzonePlatform"
        #"--ozone-platform=wayland" #only for wayland
        "--remote-debugging-port=9222"
      ];
    }).overrideAttrs
      (oldAttrs: {
        # Disable rename until fix available to make pop-launcher open google-chrome
        #postInstall = oldAttrs.postInstall or "" + ''
        #  mv $out/bin/google-chrome-stable $out/bin/google-chrome
        #'';
      });
in
{
  imports = [
    ./git.nix
    ./bat.nix
    ./mpv.nix
    ./nvim.nix
    ./fonts.nix
    ./mcfly.nix
    ./zathura.nix
    ./ani-cli.nix
    ./fusuma.nix
    ./doom-emacs.nix
    ./firefox/firefox.nix
  ];

  #  services.kdeconnect = {
  #    enable = true;
  #    indicator = true;
  #  };

  home.packages = with pkgs; [
    bc
    wget
    htop
    github-cli
    nnn
    openssl
    xplr
    koji
    aria2
    nodejs
    libclang
    gcc
    pre-commit
    gnumake
    fzf
    vlc
    tdesktop
    ncftp
    comma
    zed-editor
    postman
    capitaine-cursors
    fortune
    file
    nautilus
    go
    xcolor
    smartmontools
    jq
    kitty
    remmina
    jmeter
    yt-dlp
    eva
    ueberzug
    tree
    qbittorrent
    unzip
    picom
    cmus
    oci-cli
    conky
    fd # faster find alternative
    gromit-mpx
    pup
    progress
    starship
    nixos-option
    rustdesk
    lm_sensors
    screenkey
    android-tools
    efibootmgr
    duf
    gdu
    xclip
    direnv
    clipit
    dig
    ffmpeg
    pciutils
    nix-index # contains nix-locate
    entr
    googler
    imgp
    recode
    glow
    yazi
    papirus-maia-icon-theme
    fff
    acpi
    sxiv
    axel
    python3
    groff # for ms macros to pdf
    pandoc
    texlive.combined.scheme-small # for converting .md files to pdf
    ddgr
    ytfzf
    dua
    simplescreenrecorder
    nix-tree
    nixfmt-rfc-style
    treefmt
    (kodi.withPackages (
      p: with p; [
        inputstream-adaptive
        pvr-iptvsimple
        inputstreamhelper
      ]
    )) # kodi with jiotv, last is for drm
    #ref https://discourse.nixos.org/t/google-chrome-not-working-after-recent-nixos-rebuild/43746/8
    google-chrome
    websocat
    warp # file-transfer
    jetbrains.pycharm-community-bin
    jetbrains.idea-community-bin
  ];
  nixpkgs.config.allowUnfree = true;
}
