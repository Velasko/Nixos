{ inputs, pkgs, lib, username, ... }:
{
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  environment = {
    variables.XDG_SESSION_TYPE = "x11";
    systemPackages = with pkgs; [ dconf ];
  };

  imports = [
    inputs.nixos-wsl.nixosModules.default
    {
      wsl = {
        enable = true;
        defaultUser = username;
        wslConf.network.generateResolvConf = false;
      };
      networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];
    }
  ];
}
