{ pkgs, ... }:
let
  sys_config = if true then [ ./wsl-configuration.nix ] else [ ];
in
{
  imports = sys_config;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}

