{ ... }:
let
  sys_config = if true then [ ./wsl-configuration.nix ] else [ ];
in
{
  imports = sys_config;
}

