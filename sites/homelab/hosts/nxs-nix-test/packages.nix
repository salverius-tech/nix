{ config, lib, pkgs, ... }:

{

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

  environment = {
    systemPackages = with pkgs.xfce // pkgs; [
      bash
      cloud-init
      coreutils
      curl
      docker
      docker-buildx
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
      nixfmt
      nixpkgs-fmt
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
      zsh
      zsh-fzf-tab
      zsh-completions
      zsh-autosuggestions
      nix-zsh-completions
      zsh-syntax-highlighting    
    ];
  };

  environment.variables = {
    TZ = config.time.timeZone;
  };

}