{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    stylix.url = "github:danth/stylix";
    xremap.url = "github:xremap/nix-flake";

    dotfiles = {
      flake = false;
      url = "git+https://github.com/Velasko/dotfiles?submodules=1";
    };
    github-keys = {
      flake = false;
      url = "https://github.com/velasko.keys";
    };
    machine-id-file = {
      flake = false;
      url = "path:/etc/machine-id";
    };
    cpu-info = {
      flake = false;
      url = "path:/proc/cpuinfo";
    };
  };

  outputs = { nixpkgs, home-manager, stylix, ... } @inputs:
    let
      inherit (nixpkgs.lib.lists) foldl forEach;

      pkgs = import nixpkgs {
        config.allowUnfree = true;
        inherit platform;
      };

      platform = pkgs.config.nixpkgs.hostPlatform;
      environments = [ "main" "minimal" "work" ];
      machines = {
        id_4045046c63ab4f52b55f73688d192041 = "book4";
        id_db8e3934eee544689f3e2460bef7a0d8 = "zfs-virtualized";
      };

      username = "velasco";
    in
    {
      nixosConfigurations =
        let
          configure = environment: {
            "${environment}" = nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs stylix username environment machines; };
              modules = [
                ./system/main.nix
                ./home/base.nix
              ];
            };
          };
        in
        foldl (a: b: a // b)
          { }
          (
            forEach environments configure
          );
    };
}


