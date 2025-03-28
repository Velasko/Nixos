{ lib, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      font.normal = lib.mkForce {
        family = "Inconsolata Nerd Font";
        style = "Regular";
      };
      font.bold = lib.mkForce {
        family = "Inconsolata Nerd Font";
        style = "Bold";
      };
    };
  };
}
