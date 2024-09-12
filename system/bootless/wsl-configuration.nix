inputs.nixos-wsl.nixosModules.default
{
  wsl = {
    enable = true;
    defaltUser = username;
    wslConf.network.generatedReslovConfm = false;
    networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];
  };
};
