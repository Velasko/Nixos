{ inputs, config, lib, pkgs, username, ... }:
{
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    optimise.automatic = true;
  };

  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 1d --keep 3";
  };

  programs = {
    zsh.enable = true;
    nix-ld.enable = true;
  };

  users.users."${username}" = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keyFiles = [ inputs.github-keys.outPath ];
  };

  security.sudo.extraRules = [
    {
      commands = [{ command = "ALL"; options = [ "NOPASSWD" ]; }];
      users = [ username ];
    }
  ];

  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [
      git
    ];
    etc.nixenv.text = if config.networking.dhcpcd.extraConfig == "noarp" then "true" else "false";
  };

  system = {
    stateVersion = "24.05";
    autoUpgrade = {
      enable = true;
      allowReboot = false;
      channel = "https://channels.nixos.org/nixos-${config.system.stateVersion}";
    };
  };

}


