{ config, pkgs, inputs, lib, modulesPath, username, ... }:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ../home/base.nix
    ./common.nix
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
  programs.zsh.enable = true;

  home-manager.users."${username}".home.homeDirectory = lib.mkForce "/home/${username}";
  users.users."${username}".shell = lib.mkForce pkgs.bash;

  systemd.services."getty@tty1" = {
    overrideStrategy = "asDropin";
    serviceConfig.ExecStart = [ "" "@${pkgs.util-linux}/sbin/agetty agetty --login-program ${config.services.getty.loginProgram} --autologin ${username} --noclear --keep-baud %I 115200,38400,9600 $TERM" ];
  };

  environment.etc."issue.d/ip.issue".text = "\\4\n";
  networking.dhcpcd.runHook = "${pkgs.utillinux}/bin/agetty --reload";

  environment.systemPackages = with pkgs; [
    git
    gum
    (
      writeShellScriptBin "nix_installer" ./scripts/installer.sh
    )
  ];
}
