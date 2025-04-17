{ pkgs, ... }:

{
  # Packages for Kicad
  home.packages = with pkgs; [
    kicad
    temurin-jre-bin # Needed for kicads plugin freerouting
  ];
}
