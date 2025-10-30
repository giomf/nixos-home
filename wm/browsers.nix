{ pkgs, ... }:

{
  home.packages = with pkgs; [
    google-chrome
  ];

  programs.firefox = {
    enable = true;
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
