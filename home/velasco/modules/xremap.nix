{ inputs, ... }:
{
  imports = [
    inputs.xremap.homeManagerModules.default
  ];

  services.xremap.config = {
    keymap = [
      {
        name = "KDE remaps";
        remap = {
          super-f = "Super-KEY_PAGEUP"; # full screen on kde
        };
      }
      {
	    name = "Esc-Caps switch";
		remap = {
		  CapsLock = "Esc";
		  shift-CapsLock = "CapsLock";
		};
      }
    ];
  };
}
