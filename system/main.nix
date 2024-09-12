{ lib, inputs, ... }:
let
  inherit (lib.strings) concatStrings splitString hasInfix;
  wsl = hasInfix "microsoft" (builtins.readFile inputs.proc-version);

  bootless = wsl;
  boot-type-configuration =
    if wsl then
      [ ./bootless/configuration.nix ]
    else
      [ ./bootable/configuration.nix ];
in
{
  imports = [ ./common.nix ] ++ boot-type-configuration;
}
