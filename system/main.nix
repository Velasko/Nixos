{ wsl, ... }:
let
  bootless = wsl;
in
{

  imports = [
    ./common.nix
  ] ++ if bootless then
  [ ./wsl-configuration.nix]
  else
  [./boot-configurations.nix];
}
