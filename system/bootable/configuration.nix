{ pkgs, inputs, config, lib, machines, username, environment, virtualized, ... }:
let
  inherit (lib.strings) concatStrings splitString hasInfix;
  virtualized = hasInfix "hypervisor" (builtins.readFile inputs.cpu-info);
  machine-id = concatStrings (splitString "\n" (builtins.readFile inputs.machine-id-file));

  machine = (machines."id_${machine-id}" or "unknown");

  disk-type = if ! virtualized || machine == "zfs-virtualized" then "zfs" else "ext4";
in
{
  imports = [
    ./${machine}/hardware-configuration.nix
    ./modules/display.nix
    (import ./modules/network.nix { machine = machine; username = username; })
    ./modules/audio.nix
    inputs.disko.nixosModules.disko
    ./disko/${disk-type}.nix
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

  fileSystems."/boot".options = [ "fmask=022" "umask=0022" "defaults" ];

  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs = {
      forceImportRoot = true;
    };

    loader = {
      grub = {
        enable = !config.boot.loader.systemd-boot.enable;
        useOSProber = true;
        configurationLimit = 10;
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

    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
  powerManagement.cpufreq.min = 41000;

  hardware.uinput.enable = true;
  users.groups.uinput.members = [ username ];
  users.groups.input.members = [ username ];


}
