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
  programs.home-manager.enable = true;
  programs.zoxide.enable = true;

  # Packages
  home.packages = with pkgs; [
    # Base
    bat
    btop
    direnv
    docker-compose
    dogdns
    du-dust
    duf
    eza
    fd
    file
    fzf
    hexyl
    kmon
    nh
    nix-output-monitor
    nmap
    numbat
    procs
    ripgrep
    termscp
    tldr
    unzip
    wget
    yazi
    openssl

    # Coding
    gh
    git-crypt
    gnupg
    nixpkgs-review
  ];
}
