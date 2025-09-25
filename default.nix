{ pkgs, ... }:

{
  imports = [
    ./ssh.nix
    ./fish.nix
    ./git.nix
    ./helix.nix
    ./starship.nix
    ./zellij
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "guif";
    homeDirectory = "/home/guif";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.05";
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    zoxide.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  # Packages
  home.packages = with pkgs; [
    # Base
    bat
    btop
    docker-compose
    dogdns
    dua
    duf
    eza
    fd
    file
    fzf
    hexyl
    kmon
    nh
    nixos-rebuild-ng
    nix-output-monitor
    nmap
    numbat
    openssl
    procs
    pwgen
    ripgrep
    sd
    termscp
    tldr
    unzip
    wget
    yazi

    # Coding
    aider-chat
    gh
    git-crypt
    gnupg
    nixpkgs-review
  ];
}
