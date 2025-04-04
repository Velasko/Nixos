{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    stylix.url = "github:danth/stylix/release-24.11";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

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

      username = "velasco";
      platform = pkgs.config.nixpkgs.hostPlatform;

      pkgs = import nixpkgs {
        config.allowUnfree = true;
        inherit platform;
      };

      environments = mapAttrsToList (name: value: removeSuffix ".nix" name)
        (filterAttrs
          (n: v: v == "regular")
          (readDir ./home/${username}/environments)
        );

      machines = mapAttrsToList (name: value: name)
        (filterAttrs
          (n: v: v == "directory")
          (readDir ./system/machines)
        );
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
            iso =
              let
                machine = "unknown";
                environment = "minimal";
              in
              nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs stylix username environment machine; };
                modules = [
                  ./system/iso.nix
                ];
              };
          }
          (
            forEach (cartesianProduct { a = machines; b = environments; }) configure
          );

      homeConfigurations =
        let
          machine = "home-manager";
          environment = "main";
        in
        {
          "${machine}.${environment}" = inputs.home-manager.lib.homeManagerConfiguration {
            extraSpecialArgs = { inherit inputs stylix username environment machine; };
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            modules = [
              stylix.homeManagerModules.stylix
              ./home/velasco/home.nix
              {
                home = {
                  username = "velasco";
                  homeDirectory = "/home/velasco";
                  stateVersion = "24.11";
                };
                gtk.enable = nixpkgs.lib.mkForce false;
                programs.home-manager.enable = true;
              }
            ];
          };
        };
    };
}


