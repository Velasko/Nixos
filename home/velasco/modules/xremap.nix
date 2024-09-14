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
          super-f = "Super-KEY_PAGEUP"; # full screen on kde
        };
      }
    ];
  };
}
