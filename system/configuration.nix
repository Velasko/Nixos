{ pkgs, username, inputs, config, machine, ... } : {
	imports = [
		./modules/display.nix
		./modules/network.nix
		./modules/audio.nix
		inputs.disko.nixosModules.disko
		./disko/${machine}.nix
	];

	nix = {
		settings.experimental-features = [ "nix-command" "flakes" ];
		optimise.automatic = true;
	};

	disko.enableConfig = true;

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
				enable = true;
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

	powerManagement.cpuFreqGovernor = "performance";
	powerManagement.cpufreq.min = 41000;

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

	users.users."${username}"= {
		shell = pkgs.zsh;
		isNormalUser = true;
		description = username;
		extraGroups = [ "networkmanager" "wheel" ];
		openssh.authorizedKeys.keyFiles = [ inputs.github-keys.outPath ];
	};

	security.sudo.extraRules = [
		{
			commands = [ { command = "ALL"; options = [ "NOPASSWD" ]; } ];
			users = [ username ];
		}
	];

	hardware.uinput.enable = true;
	users.groups.uinput.members = [ username ];
	users.groups.input.members = [ username ];

	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		git
	];

	system = {
		stateVersion = "24.05";
		autoUpgrade = {
			enable = true;
			allowReboot = false;
			channel = "https://channels.nixos.org/nixos-${config.system.stateVersion}";
		};
	};
}
