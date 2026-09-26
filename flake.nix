{
  description = "NixOS configuration of Ththree";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
          ./modules/virt/virt.nix
          ./modules/sound/sound.nix
          ./modules/network/network.nix
        ];
      };
    };
}
