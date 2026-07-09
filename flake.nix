{
    description = "Deathlesz' NixOS";

    outputs = inputs @ {...}: let
        # NOTE: hard-coded for now
        system = "x86_64-linux";

        lib = inputs.nixpkgs.lib;
        libM = lib // import ./lib {lib = lib;};

        hosts = lib.filter (x: x != null && x != "__TEMPLATE") (lib.mapAttrsToList
        (name: value:
            if (value == "directory")
            then name
            else null)
        (builtins.readDir ./hosts));
    in {
        nixosConfigurations = builtins.listToAttrs (map (host: {
            name = host;
            value = lib.nixosSystem {
                inherit system;

                modules = [
                    {
                        nixpkgs = {
                            config = {
                                allowUnfree = true;
                                permittedInsecurePackages = [
                                    "electron-39.8.10"
                                ];
                            };
                            overlays = [inputs.nix-firefox-addons.overlays.default inputs.nix-cachyos-kernel.overlays.pinned];
                        };
                    }

                    # host-specific configuration
                    {config.networking.hostName = host;}
                    ./hosts/${host}

                    # common configuration
                    ./modules/system

                    inputs.home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.backupFileExtension = "hm-backup";

                        home-manager.extraSpecialArgs = {
                            inherit system;
                            inherit libM;
                            inherit inputs;
                        };
                    }
                ];

                specialArgs = {
                    inherit system;
                    inherit libM;
                    inherit inputs;
                };
            };
        })
        hosts);
    };

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nix-firefox-addons.url = "github:osipog/nix-firefox-addons";
        nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        stylix = {
            url = "github:nix-community/stylix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixvim.url = "github:nix-community/nixvim";
        niri = {
            url = "github:sodiboo/niri-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        alejandra = {
            url = "github:kamadorueda/alejandra/4.0.0";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };
}
