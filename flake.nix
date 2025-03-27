{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    stylix.url = "github:danth/stylix/release-24.11";

    dotfiles = {
      flake = false;
      url = "git+https://github.com/Velasko/dotfiles?submodules=1";
    };
    github-keys = {
      flake = false;
      url = "https://github.com/velasko.keys";
    };
  };

  outputs = { nixpkgs, home-manager, stylix, ... } @inputs:
    let
      inherit (builtins) readDir;
      inherit (nixpkgs.lib.attrsets) cartesianProduct filterAttrs mapAttrsToList;
      inherit (nixpkgs.lib.lists) foldl forEach;
      inherit (nixpkgs.lib.strings) removeSuffix;

      pkgs = import nixpkgs {
        config.allowUnfree = true;
        inherit platform;
      };

      username = "velasco";
      platform = pkgs.config.nixpkgs.hostPlatform;
      environments = mapAttrsToList (name: value: removeSuffix ".nix" name)
        (filterAttrs
          (n: v: v == "regular")
          (readDir ./home/${username}/environments)
        );
      machines = [
        "book4"
        # "zfs-virtualized"
      ];

    in
    {
      nixosConfigurations =
        let
          configure = sys_config:
            let
              machine = sys_config.a;
              environment = sys_config.b;
            in
            {
              "${machine}.${environment}" = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs stylix username environment machine; };
                modules = [
                  ./system/main.nix
                  ./home/base.nix
                ];
              };
            };
        in
        foldl (a: b: a // b)
          {
            iso = nixpkgs.lib.nixosSystem {
              modules = [
                ./system/iso.nix
              ];
            };
          }
          (
            forEach (cartesianProduct { a = machines; b = environments; }) configure
          );
    };
}


