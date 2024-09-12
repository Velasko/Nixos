{config, pkgs, ...} : {
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    alsa.support32Bit = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    pavucontrol
  ];
}
