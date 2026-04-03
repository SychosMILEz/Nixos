{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.extraModulePackages = with
  config.boot.kernelPackages; [
    v4l2loopback
];

  fileSystems."/home/smilez/BoNeZ" = {
      device = "/dev/disk/by-uuid/e3a1243a-a90a-4882-9fa8-74715d5af91b";
      fsType = "ext4";
      options =  [ "nofail" "defaults" ];
};

  fileSystems."/home/smilez/Graves" = {  
      device = "/dev/disk/by-uuid/2ca3f6ff-0db2-47f8-8f23-be89e3accf26";  
      fsType = "ext4";  
      options =  [ "nofail" "defaults" ];
};

  networking.hostName = "Goblinz-Lair"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  services.greetd.enable = true;
  programs.regreet.enable = true;
  
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.smilez = {
    isNormalUser = true;
    description = "Sycho sMILEZ";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "input" ];
    shell = pkgs.fish;
    packages = with pkgs; [
    tree
];
  };

  programs.hyprland.enable = true;
  services.hypridle.enable = true;
  programs.hyprlock.enable = true;
  programs.hyprland.xwayland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    openssl
    glib
    gtk3
    nss
    nspr
    dbus
    atk
    pango
    cairo
    gdk-pixbuf
    expat
    libxkbcommon
    libx11
    libxcursor
    libxrandr
    libxrender
    libxi
    libxtst
    libGL
    libGLU
    alsa-lib
    mesa
    libGL
    vulkan-loader
  ];

  # Appimage plugs
   programs.appimage = {
   enable = true;
   package = pkgs.appimage-run.override { extraPkgs = pkgs: with pkgs; [
            libxcrypt
            libxcrypt-legacy
            libffi
            libyaml
            icu
            imagemagick
        ];};
};

  programs.steam.enable = true;
  programs.steam.protontricks.enable = true;
  
  programs.gamemode.enable = true;
  programs.fish.enable = true;
  services.power-profiles-daemon.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true;
  security.polkit.enable = true;
  services.flatpak.enable = true;
  
  xdg.portal = {
     enable = true;
     xdgOpenUsePortal = true;
     extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
       ];
       config.common.default = [ "hyprland" "gtk" ];
};

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
#== Core Desktop ==#
    mako
    wget
    floorp-bin
    brave
    fuzzel
    mpvpaper
    wl-clipboard
    cliphist
    nemo
    yazi
    quickshell
    mpv
    starship
    kitty
    hyprgraphics
    hyprlang
    hyprutils
    hyprsysteminfo
    bat
    hyprpolkitagent
    obsidian

#== Audio/Media ==#
    wireplumber
    pipewire
    pavucontrol
    playerctl
    ffmpeg-full
    strawberry
    pulseaudio
    lollypop
    audacity
    easyeffects
    ardour
    qbittorrent-enhanced

#== Video/Image Editing ==#
    gimp3-with-plugins
    inkscape
    blender
    pinta

#== Coding/Dev ==#
    git
    gcc
    gnumake
    cmake
    pkg-config
    ninja
    kdePackages.kate
    python3
    nodejs
    neovim
    rustic
    go
    godot
    glib
    marker
    libzip
    SDL2
    libpng
    nlohmann_json
    tinyxml-2
    spdlog
    SDL2_net
    boost
    libogg
    libvorbis
    lsb-release
    libxext
    libx11

#== Gaming ==#
    lutris
    heroic
    itch
    wineWow64Packages.staging
    winetricks
    mangohud
    vkbasalt
    goverlay
    vesktop
    r2modman
    protonplus
    gamescope
    
#== Emulators ==#
    rpcs3
    pcsx2
    dolphin-emu
    ryubing
    snes9x
    dgen-sdl
    rmg-wayland
    xemu
    attract-mode

#== Utilities ==#
    fastfetch
    btop
    htop
    neofetch
    unzip
    wget
    curl
    grim slurp swappy
    xdg-utils
    file-roller
    thunderbird
    lm_sensors
    radeontop
    gearlever
    popsicle
    polkit
    eza
    docker
    parabolic
    wlogout
    fanctl
    piper
    vulkan-tools
    squashfsTools
    vivaldi-ffmpeg-codecs
    cava
    libxcrypt-legacy
    fuse
    udisks
    gvfs
    gpu-viewer
    lact
    fuse3
    appimage-run
    
];

# Fonts
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    fira-code
    dejavu_fonts
];

# Audio (Pipewire + WirePlumber)
services.pulseaudio.enable = false;

services.pipewire = {
   enable = true;
   alsa.enable = true;
   alsa.support32Bit = true;
   pulse.enable = true;
   jack.enable = true;
};

# Streaming + Recording
  programs.obs-studio = {
    enable = true;
  plugins = with pkgs.obs-studio-plugins; [
   obs-backgroundremoval
   obs-pipewire-audio-capture
   obs-vaapi
   obs-gstreamer
   obs-vkcapture
   pkgs.obs-studio-plugins.obs-multi-rtmp
 ];  
};

# GPU + CPU Tuning
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;
  hardware.amdgpu.opencl.enable = true;
  services.xserver.videoDrivers = ["amdgpu"];
  hardware.graphics = {
  enable = true;
  enable32Bit = true;
  extraPackages = with pkgs; [
    mesa
    vulkan-loader
    vulkan-validation-layers
 ];
  extraPackages32 = with pkgs.pkgsi686Linux; [
    mesa
    vulkan-loader
 ];
};

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.config.permittedInsecurePackages = [
  "freeimage-3.18.0-unstable-2024-04-18"
  "mbedtls-2.28.10"
 ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
