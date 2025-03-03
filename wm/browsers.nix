{ pkgs, ... }:

{
  home.packages = with pkgs; [
    google-chrome
  ];

  programs.librewolf = {
    enable = true;
    settings = {
      "privacy.clearOnShutdown.history" = true;
      "privacy.clearOnShutdown.cookies" = true;
      "browser.privatebrowsing.autostart" = true;
    };
    profiles = {
      guif = {
        id = 0;
        name = "guif";
        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          darkreader
          floccus
          keepassxc-browser
          ublock-origin
        ];
      };
    };
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    profiles = {
      guif = {
        id = 0;
        name = "guif";
        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          darkreader
          floccus
          keepassxc-browser
          ublock-origin
        ];
      };
    };
  };
}
