{
  description = "Simple flake to manage my NixOS Systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/?rev=b73c2221a46c13557b1b3be9c2070cc42cf01eb3"; #unstable required for cosmic as yet to be merged to stable
    deploy-rs.url = "github:serokell/deploy-rs";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.4.1";

    #Always use the same nixpkgs for both system + <module>
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-snapd = {
      url = "github:nix-community/nix-snapd";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-cosmic, ... }@inputs: {
    nixosConfigurations = {
      server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
	  ./modules/home-manager
          ./systems/server/configuration.nix
        ];
      };

      phoenix = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./systems/phoenix
	  ./modules/home-manager
          inputs.home-manager.nixosModules.default
        ];
      };

      blade = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./systems/blade
	  ./modules/home-manager
          inputs.nix-snapd.nixosModules.default
          inputs.home-manager.nixosModules.default
	  inputs.nix-flatpak.nixosModules.nix-flatpak
        ];
      };
      cospi = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./systems/cospi
	  ./modules/home-manager
	  {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
          }
          nixos-cosmic.nixosModules.default
          inputs.nix-snapd.nixosModules.default
          inputs.home-manager.nixosModules.default
	  inputs.nix-flatpak.nixosModules.nix-flatpak
        ];
      };
    };

    deploy.nodes = {
      server = {
        hostname = "server"; #should be same in ~/.ssh/config
        sshUser = "root"; #should be same in ~/.ssh/config
        profiles.system = {
          user = "root";
          path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.server;
        };
      };

      phoenix = {
        hostname = "phoenix"; #should be same in ~/.ssh/config
        sshUser = "root"; #should be same in ~/.ssh/config
        profiles.system = {
          user = "root";
          path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.phoenix;
        };
      };
    };

    # This is highly advised, and will prevent many possible mistakes
    checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) inputs.deploy-rs.lib;
  };
}
