{
  description = "nxs-nix-test";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs, ... }:
    let
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        nxs-nix-test = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./default.nix ];
      };
    };
  };
}