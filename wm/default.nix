{ pkgs, ... }:

{
  imports = [
    ./kitty.nix
    ./browsers.nix
    # ./hyprland.nix
    #    ./keyring.nix
    # ./vscode.nix
  ];

  # Packages
  home.packages = with pkgs; [
    # Base

    # Office
    gimp
    keepassxc
    libreoffice-qt
    thunderbird
    vlc
    xournalpp

    # 3D Printing
    #    cura deactivate due to some build errors
    freecad

    # Social
    discord
    element-desktop
    nextcloud-client
    spotify
    telegram-desktop
  ];
}
