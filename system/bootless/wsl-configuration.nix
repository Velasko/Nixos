{ username, ... }:
{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
  ];

  wsl = {
    enable = true;
    defaltUser = username;
    wslConf.network.generatedReslovConfm = false;
    networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];
  };

}
