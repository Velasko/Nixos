{ pkgs, inputs, config, lib, machine, username, environment, virtualized, ... }:
let
  inherit (lib.strings) concatStrings splitString hasInfix;
  virtualized = false;

  disk-type = if ! virtualized || machine == "zfs-virtualized" then "zfs" else "ext4";
in
{
  imports = [
    ./modules/display.nix
    ./modules/network.nix
    ./modules/audio.nix
    inputs.disko.nixosModules.disko
    ./modules/disko/${disk-type}.nix
  ];

  disko.enableConfig = true;
  disko.devices.disk.main.device =
    if virtualized then
      "/dev/vda"
    else if lib.builtins.elem "nvme" config.boot.initrd.availableKernelModules then
      "/dev/nvme0n1"
    else
      "/dev/sda"
  ;

  fileSystems."/boot".options = [ "fmask=0022" "umask=0022" "defaults" ];

  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs = {
      forceImportRoot = true;
    };

    tmp.tmpfsSize = "75%";

    loader = {
      timeout = 1;
      grub = {
        enable = !config.boot.loader.systemd-boot.enable;
        useOSProber = true;
        configurationLimit = config.boot.loader.systemd-boot.configurationLimit;
        efiSupport = true;
        zfsSupport = true;
        efiInstallAsRemovable = !config.boot.loader.systemd-boot.enable;
        mirroredBoots = [
          { devices = [ "nodev" ]; path = "/boot"; }
        ];
      };

      systemd-boot = {
        enable = lib.mkDefault true;
        configurationLimit = 10;
      };

      efi = {
        canTouchEfiVariables = config.boot.loader.systemd-boot.enable;
        efiSysMountPoint = "/boot";
      };
    };

    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "zswap.enabled=1"
    ];

    kernelModules = [ "lz4" "z3fold" ];

    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
  };

  systemd = {
    services = {
      zswap-configure = {
        description = "Configure zswap";
        wantedBy = [ "multi-user.target" ];
        serviceConfig.Type = "oneshot";
        script = ''
          			  echo lz4 > /sys/module/zswap/parameters/compressor
          			  echo z3fold > /sys/module/zswap/parameters/zpool
          			'';
      };
      numLockOnTty = {
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          # /run/current-system/sw/bin/setleds -D +num < "$tty";
          ExecStart = lib.mkForce (pkgs.writeShellScript "numLockOnTty" ''
            				  for tty in /dev/tty{1..6}; do
            					  ${pkgs.kbd}/bin/setleds -D +num < "$tty";
            				  done
            				'');
        };
      };
    };
    sleep.extraConfig = ''
      		AllowSuspend=yes
      		AllowHibernation=yes
      		AllowHybridSleep=yes
      		AllowSuspendThenHibernate=yes
      		HibernateDelaySec=35m
      		SuspendState=mem
      	  '';
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
  powerManagement.cpufreq.min = 41000;

  hardware.uinput.enable = true;
  users.groups.uinput.members = [ username ];
  users.groups.input.members = [ username ];
}
