{ config, lib, pkgs, ... }:

{

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" "repl-flake" ];
  };

 # Reference the username and password from secrets.nix
  users.users."${secrets.user.username}" = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "systemd-journal" ];
    shell = pkgs.zsh;
    hashedPassword = "${secrets.user.password}";
  };

  # Set the root's hashed password from secrets.nix
  users.extraUsers.root = {
    hashedPassword = "${secrets.root.password}";
  };

  security.sudo.wheelNeedsPassword = false;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = [ pkgs.zsh ];

  programs = { 
    nix-ld.enable = true; 
  };

  programs.zsh.enable = true;
  programs.zsh.shellAliases = {
    l    = "ls -alh";
    ll   = "ls -l";
    ls   = "ls --color=tty";
    dps  = ''docker ps --format="table {{.Names}}\t{{.ID}}\t{{.Image}}\t{{.RunningFor}}\t{{.State}}\t{{.Status}}"'';
    dpsp = ''docker ps --format="table {{.Names}}\t{{.ID}}\t{{.Image}}\t{{.RunningFor}}\t{{.State}}\t{{.Status}}\t{{.Ports}}"'';
    nix-gc = "nix-store --gc";
    nix-rs = "sudo nixos-rebuild switch";
    nix-code = "code /etc/nixos/configuration.nix";
  };

}