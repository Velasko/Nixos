{ wsl, ... }:
let
  sys_config = if wsl then [ ./wsl-configuration.nix ] else [ ];
in
{
  imports = sys_config;
}

