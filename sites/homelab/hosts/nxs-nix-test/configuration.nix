{ config, lib, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ./starship.nix 
  ];

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" "repl-flake" ];
  };

  system.autoUpgrade.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Define a user account.
  users.users.systemboss = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "systemd-journal" ];
    shell = pkgs.zsh;
    # hashedPassword = "${HASHED_PASSWORD}";
    #packages = with pkgs; [];
  };

  security.sudo.wheelNeedsPassword = false;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = [ pkgs.zsh ];

  programs = { 
    zsh.enable = true;
    nix-ld.enable = true; 
  };

  # Use the GRUB 2 boot loader.
  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    dejavu_fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs.xfce // pkgs; [
      bash
      cloud-init
      coreutils
      curl
      docker
      docker-buildx
      docker-compose
      eza
      findutils
      fzf
      git
      gnumake
      gnutar
      htop
      iproute2
      jq
      just
      killall
      less
      libuuid
      linuxHeaders
      mkpasswd
      netcat
      nettools
      nmap
      openssl
      python3
      python3Packages.pip
      ripgrep
      rsync
      spice-vdagent
      ssh-import-id
      starship
      strace
      sysstat
      tealdeer
      tree
      tzdata
      unzip
      util-linux
      wget
      yq
      zsh-autosuggestions
      zsh-syntax-highlighting
    ];
  };

  environment.variables = {
    TZ = config.time.timeZone;
  };

  #services.cloud-init.enable = true;
  services.openssh.enable = true;
  services.qemuGuest.enable = true;
  virtualisation.docker.enable = true;

  system.stateVersion = "23.11";
}