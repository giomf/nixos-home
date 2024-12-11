{ ... }:
{
  services.ssh-agent.enable = true;
  services.gpg-agent.enable = true;
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host backup.guif.dev
        HostName backup.guif.dev
        Port 30049
    '';
  };
}
