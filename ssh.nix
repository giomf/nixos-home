{ ... }:
{
  services.ssh-agent.enable = true;
  services.gpg-agent.enable = true;
  programs.ssh = {
    enable = false;
  };
}
