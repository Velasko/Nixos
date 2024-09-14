{ inputs, ... }:
{
  imports = [
    inputs.xremap.homeManagerModules.default
  ];

  services.xremap.config = {
    keymap = [
      {
        name = "main remaps";
        remap = {
          super-y = {
            launch = [ "firefox" ];
          };
        };
      }
    ];
  };
}
