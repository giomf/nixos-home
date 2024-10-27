{ pkgs, ... }:

{
  services.gnome-keyring.enable = true;
  home.packages = with pkgs; [
    libgnome-keyring
    gnome-keyring
  ];
}
