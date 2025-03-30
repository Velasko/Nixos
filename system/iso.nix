{ config, pkgs, inputs, lib, modulesPath, username, ... }:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ../home/base.nix
  ];

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
    config.allowUnfree = true;
  };

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    extraOptions = "experimental-features = nix-command flakes";
  };

  services = {
    qemuGuest.enable = true;
    openssh.settings.PermitRootLogin = lib.mkForce "no";
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = lib.mkForce [
      "ext4"
      # "zfs"
      "btrfs"
      "vfat"
      "f2fs"
      "xfs"
      "ntfs"
    ];
  };

  networking = {
    hostName = "velasco-nixiso";
  };

  # gnome power settings do not turn off screen
  systemd = {
    services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
    targets = {
      sleep.enable = false;
      suspend.enable = false;
      hibernate.enable = false;
      hybrid-sleep.enable = false;
    };
  };

  users.extraUsers.root.password = "nixos";
  home-manager.users."${username}".home.homeDirectory = lib.mkForce "/home/${username}";
  users.users."${username}" = {
    isNormalUser = true;
  };

  environment.systemPackages = with pkgs; [
    git
    gum
    (
      writeShellScriptBin "nix_installer"
        ''
          	 #!/usr/bin/env bash
          	 git clone https://github.com/velasko/nixos $HOME/nixos
        ''
    )
  ];
}
