{ pkgs, ... }:

{
  home.packages = with pkgs; [
    diffnav
    tig
    delta
  ];

  programs.git = {
    enable = true;
    extraConfig = {
      core.excludesfile = "~/.global_gitignore";
      push.autoSetupRemote = true;
      pager.diff = "diffnav";
      diff = {
        colorMoved = "default";
      };
      merge = {
        conflictstyle = "diff3";
      };
      include = {
        path = (
          builtins.fetchurl {
            url = "https://raw.githubusercontent.com/dandavison/delta/master/themes.gitconfig";
            sha256 = "sha256:17z9q785y0g5isdavc86siz75w33r1i2yri9m1ih75p6553ymf2g";
          }
        );
      };
    };
    delta = {
      enable = true;
      options = {
        features = "mantis-shrimp-lite";
        side-by-side = true;
        line-numbers = true;
      };
    };
  };
}
