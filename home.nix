{ config, pkgs, ... }:

{
  home.username = "smilez";
  home.homeDirectory = "/home/smilez";
  programs.git.enable = true;
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
  sddm-sugar-dark
  kdePackages.sddm
];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
};

  gtk = {
    enable = true;
    theme = {
    package = pkgs.sweet;
    name = "Sweet-Dark";
};
  iconTheme = {
    package = pkgs.papirus-icon-theme;
    name = "Papirus-Dark";
};
   font = {
     name = "JetBrainsMono Nerd Font";
     size = 11;
  };
};

  wayland.windowManager.hyprland.systemd.variables = ["--all"];

  programs.fish = {
    enable = true;
    shellAliases = {
      ll = "eza -lah --git";
      gs = "git status";
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#Goblinz-Lair";
      updateos = "cd /etc/nixos sudo nix flake update";
     };
    };

}
