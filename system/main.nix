{ lib, inputs, ... }:
let
  # Gotta find a way to check  if it's running whithin WSL
  # inherit (lib.strings) concatStrings hasInfix;
  # wsl = hasInfix "microsoft" (builtins.readFile inputs.proc-version);

  bootless = false;
  boot-type-configuration =
    if false then
      [ ./bootless/configuration.nix ]
    else
      [ ./bootable/configuration.nix ];
in
{
  imports = [ ./common.nix ] ++ boot-type-configuration;
}
