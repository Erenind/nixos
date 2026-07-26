{
  description = "NixOS configuration of Ththree";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs =
    { self, nixpkgs, ... }:
    {
      nixosConfigurations.Ththree = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
	  ./modules/nvim/nvim.nix
        ];
      };
    };
}
