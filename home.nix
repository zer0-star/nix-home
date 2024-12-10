{
  config,
  pkgs,
  inputs,
  overlays,
  ...
}: let
  my-python-packages = pypkgs:
    with pypkgs; [
      pandas
      numpy
      matplotlib
      jupyterlab
      scikitimage
      scikit-learn
      openpyxl
      online-judge-tools
      pwntools
      pyyaml
      bibtexparser
      # (pypkgs.callPackage ./pkgs/wayremap {})
      pyclip
      pytorch
      pygments
      pycryptodome
      selenium
      polars
    ];

  obs-wl = pkgs.writeScriptBin "obs-wl" ''
    exec ${config.programs.obs-studio.finalPackage}/bin/obs -platform xcb
  '';
in {
  nix.package = pkgs.nixVersions.latest;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    # keep-outputs = true;
    # keep-derivations = true;
    cores = 0;
    substituters = [
      # "https://iohk.cachix.org"
      # https://herp-slum.cachix.org
      # "https://cache.iog.io"
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "herp-slum.cachix.org-1:6SC4HZSxqnmi6Jyxg+Omz+8o2uz8r4sgrz+cB1hn42I="
      "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    netrc-file = "${config.xdg.configHome}/nix/netrc";
    # trusted-users = ["zer0-star"];
  };

  nix.extraOptions = ''
    !include ./secret-token.conf
  '';

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./modules/sway.nix
    ./modules/sway/waybar.nix
    ./modules/pipewire.nix
    ./modules/xremap.nix
  ];

  nixpkgs.overlays =
    overlays
    ++ [
      # (import ./overlays/hls.nix)
      (self: super: {
        evremap = self.callPackage ./pkgs/evremap {};
      })
    ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "zer0-star";
  home.homeDirectory = "/home/zer0-star";

  home.packages = with pkgs; [
    cachix

    man-pages
    man-pages-posix

    pciutils
    usbutils
    lshw
    xdg-utils
    libinput
    openssl
    powertop

    playerctl

    sway-contrib.grimshot
    swaylock-effects
    swayidle
    slurp
    grim
    mako
    wofi
    kanshi
    wl-clipboard
    wob
    brightnessctl
    pamixer
    wev
    v4l-utils
    wf-recorder
    clipman
    nemo
    evince
    pavucontrol
    evremap
    nomacs
    mpv
    wl-mirror
    (callPackage ./pkgs/thorium {})
    obs-wl

    rnnoise-plugin

    aria2
    wget
    eza
    fd
    du-dust
    duf
    hexyl
    ripgrep
    ripunzip
    # neofetch
    fastfetch
    # gh
    ffmpeg
    imagemagick
    ghostscript
    pdftk
    zip
    unzip
    file
    mimeo
    mold
    yt-dlp
    speedtest-cli
    pandoc
    gdb
    pwndbg
    docker_27
    docker-compose
    bat
    lazygit
    mariadb.client
    p7zip-rar
    # (pkgs.callPackage ./pkgs/imhex.nix {})
    nodePackages.gitmoji-cli
    ngrok
    cloudflared
    pwncat
    socat
    nmap
    neovim
    htop
    lsof
    tty-clock
    pipes-rs
    jq
    libimobiledevice
    usbmuxd
    google-cloud-sdk
    act
    stegseek
    binwalk
    rlwrap
    zbar
    zxing
    inetutils
    dig
    dogdns
    tokei
    kaggle
    hugo
    nnn
    mdbook
    fzf
    ghq
    bottom
    gdu
    httpie
    procs
    zellij
    # termusic
    qemu
    tre-command
    tldr
    units
    dive

    # (libsForQt5.callPackage ./pkgs/libtas { })
    # (libsForQt5.callPackage ./pkgs/med { })

    supercollider

    yubioath-flutter
    yubikey-manager

    (lib.lowPrio (python3.withPackages my-python-packages))
    pypy3
    rye
    uv
    nodejs_latest
    corepack_latest
    # npm
    deno
    bun
    nim
    nimlangserver
    nimble
    stack
    cabal-install
    haskellPackages.cabal-gild
    ghc
    # haskell.compiler.ghc884
    # (haskell-language-server.override { supportedGhcVersions = ["90" "92" "925"]; })
    haskell-language-server
    haskellPackages.haskell-debug-adapter
    # haskellPackages.brittany
    # haskellPackages.hls-brittany-plugin
    lua5_1
    luarocks
    agda
    cmake
    extra-cmake-modules
    gcc_latest
    boost.dev
    clang-tools
    ocaml
    satysfi
    (callPackage ./pkgs/satysfi-language-server {})
    # rustc
    # rustfmt
    # cargo
    # clippy
    # rust-analyzer
    # rust-analyzer-nightly
    rustup
    cargo-tauri
    trunk
    go
    koka
    purescript
    spago
    dotnet-sdk
    # sage
    # (sage.override { requireSageTests = false; })
    metals
    # (pkgs.callPackage ./pkgs/mint.nix {})
    # (pkgs.callPackage ./pkgs/ante {})
    # (pkgs.callPackage ./pkgs/malfunction {})
    heroku
    elan
    php
    php.packages.composer
    # pypy3
    sbt
    scala_3
    jdk21
    kubectl
    k3d
    kustomize
    nasm
    nixd
    alejandra
    deadnix
    statix
    julia
    isabelle
    uiua

    # texlive.combined.scheme-full
    texliveFull

    # citra

    zotero
    inkscape

    gnumake
    gnutar

    firefox
    thunderbird
    # betterbird
    bitwarden
    bitwarden-cli
    gimp
    gof5
    # logseq
    libreoffice
    wireshark

    # (callPackage ./pkgs/track-cli {})

    prismlauncher
    tetrio-desktop

    # fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    noto-fonts-extra
    (nerdfonts.override {fonts = ["VictorMono" "Cousine" "DejaVuSansMono"];})
    roboto
    roboto-slab
    source-han-sans-japanese
    source-han-serif-japanese
    source-han-code-jp
    kanit-font
    (callPackage ./pkgs/cica {})
    (callPackage ./pkgs/juisee-nf {})
    monaspace

    #unfree
    unityhub
    # (pkgs.callPackage ./pkgs/unityhub {})
    # minecraft
    discord
    (vivaldi.override {
      proprietaryCodecs = true;
      # enableWidevine = true;
    })
    # vivaldi-ffmpeg-codecs
    # widevine-cdm
    spotify
    zoom-us
    # (pkgs.callPackage ./pkgs/inkdrop.nix { })
    # notable
    slack
    tor-browser-bundle-bin
    # postman
    jetbrains.rider
    (callPackage ./pkgs/parsec {})
  ];

  home.shellAliases = {
    l = "eza -lah --icons";
    # homeswitch = "home-manager switch --flake \"$HOME/nix-home#zer0-star\" --impure";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.sessionPath =
    []
    ++ map (p: "${config.home.homeDirectory}" + p) [
      "/.cargo/bin"
      "/.nimble/bin"
      "/.local/bin"
      "/.cabal/bin"
    ];

  fonts.fontconfig.enable = true;

  home.pointerCursor = {
    # package = pkgs.nur.repos.ambroisie.volantes-cursors;
    # name = "volantes_light_cursors";
    # name = "volantes_cursors";
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 64;
    x11.enable = true;
  };

  # systemd.user.services.evremap =
  #   let
  #     config-file = ./etc/evremap.toml;
  #   in {
  #     Install.WantedBy = [ "graphical-session.target" ];
  #     Service = {
  #       ExecStart = "${pkgs.evremap}/bin/evremap remap ${config-file}";
  #       Restart = "always";
  #     };
  #   };

  gtk = {
    enable = true;
    theme = {
      name = "Layan-dark-solid";
      package = pkgs.layan-gtk-theme;
    };
    iconTheme = {
      name = "Nordzy";
      package = pkgs.nordzy-icon-theme;
    };
  };

  programs.opam.enable = true;

  programs.go.enable = true;

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "https";
      prompt = "enabled";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.nushell = {
    enable = true;
    environmentVariables = {
      PATH = "($env.PATH | append [${pkgs.lib.concatStringsSep "," config.home.sessionPath}])";
    };
    shellAliases = {
      l = "ls -la";
      homeswitch = "home-manager switch --flake \"~/nix-home#zer0-star\" --impure";
    };
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
      export GPG_TTY="$(tty)"
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
      gpgconf --launch gpg-agent
    '';
    loginExtra = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec sway
      fi
    '';
    prezto = {
      enable = true;
      # prompt.theme = "paradox";
      pmodules = [
        # "environment"
        "terminal"
        # "editor"
        "history"
        "directory"
        "spectrum"
        "utility"
        "completion"
        # "prompt"
        # "git"
        # "haskell"
      ];
    };
  };

  programs.fish = {
    enable = true;
    loginShellInit = ''
      if test -z $DISPLAY; and test (tty) = "/dev/tty1"
        exec sway
      end
    '';
    shellAbbrs = {
      gg = "ghq get";
    };
    plugins = with pkgs.fishPlugins; [
      {
        name = "z";
        src = z.src;
      }
      {
        name = "fzf-fish";
        src = fzf-fish.src;
      }
      {
        name = "fish-ghq";
        src = pkgs.fetchFromGitHub {
          owner = "zer0-star";
          repo = "fish-ghq";
          rev = "master";
          hash = "sha256-YJ7AhTQSDc+t0C/v4Zx5jB9jcU4jHwmZT0kXhPuH8S4=";
        };
      }
    ];
    functions = {
      zz = ''
        z -l | fzf -n 2 | awk '{ print $2 }' | read recent
        if [ $recent ]
            cd $recent
        end
      '';
    };
  };

  programs.man = {
    generateCaches = false;
  };

  programs.starship = {
    enable = true;
    settings = {
      format = pkgs.lib.concatStrings [
        "$all"
      ];

      directory = {
        home_symbol = "[home]";
      };

      hostname = {
        ssh_only = false;
        style = "bold green";
      };

      username = {
        show_always = true;
        format = "[$user]($style)@";
      };

      gcloud = {
        disabled = true;
      };

      scala.disabled = true;
    };
  };

  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./etc/wezterm.lua;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      general.import = [
        "${pkgs.alacritty-theme}/dracula.toml"
      ];
      window.opacity = 0.7;
      # font.size = 13.0;
      font.normal.family = "Juisee NF";
      keyboard.bindings = [
        {
          key = "Equals";
          mods = "Control|Shift";
          action = "IncreaseFontSize";
        }
      ];
    };
  };

  programs.yazi = {
    enable = true;
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
    ];
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      ms-vscode.cpptools
      github.copilot
      haskell.haskell
      rust-lang.rust-analyzer
      tomoki1207.pdf
      # matklad.rust-analyzer-nightly
      marp-team.marp-vscode
    ];
  };

  programs.git = {
    enable = true;

    userName = "zer0-star";
    userEmail = "zer0star.65535@gmail.com";

    difftastic = {
      enable = true;
    };

    signing = {
      key = "9009FF60684DBF542B8F84DA5AF0540F8ADAD765";
      signByDefault = true;
    };

    lfs.enable = true;

    aliases = {
      pushf = "push --force-with-lease --force-if-includes";
    };

    extraConfig = {
      # credential.helper = "store";
      core.editor = "nvim";
      init.defaultBranch = "main";
      pull.ff = "only";
    };
  };

  programs.gpg = {
    enable = true;
    scdaemonSettings = {
      disable-ccid = true;
      reader-port = "Yubico Yubi";
      disable-application = "piv";
      application-priority = "openpgp";
    };
  };

  services.keybase.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    # pinentryFlavor = "curses";
    pinentryPackage = pkgs.pinentry-curses;
  };

  programs.ssh = {
    enable = true;
    forwardAgent = true;
    matchBlocks = {
      "git.trap.jp" = {
        extraOptions = {
          HostkeyAlgorithms = "+ssh-rsa";
          PubkeyAcceptedAlgorithms = "+ssh-rsa";
        };
      };
    };
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "tokyonight";
      keys.normal = {
        space.w = ":w";
        space.q = ":q";
        G = "goto_file_end";
      };
      editor.indent-guides = {
        render = true;
        character = "╎";
      };
    };
  };

  programs.neovim = {
    enable = false;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraConfig = ''
      let mapleader=','
      let maplocalleader='\'
      set clipboard+=unnamed
      set number
      set title
      set ambiwidth=double
      set tabstop=4
      set expandtab
      set shiftwidth=2
      set smartindent
      set list
      set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
      set nrformats-=octal
      set hidden
      set history=50
      set virtualedit=block
      set whichwrap=b,s,[,],<,>
      set backspace=indent,eol,start
      set wildmenu
    '';

    plugins = let
      skkeleton = pkgs.vimUtils.buildVimPluginFrom2Nix {
        name = "skkeleton";
        src = pkgs.fetchFromGitHub {
          owner = "vim-skk";
          repo = "skkeleton";
          rev = "79c703865707984761f379870dd3a7522ac5ef04";
          sha256 = "sha256-gAJl9BX//QDP1TO7uo8c/LooKgeST73CmecAnVfIFK4=";
        };
      };
      denops-vim = pkgs.vimUtils.buildVimPluginFrom2Nix {
        name = "denops-vim";
        src = pkgs.fetchFromGitHub {
          owner = "vim-denops";
          repo = "denops.vim";
          rev = "53f25d7f2d20c7064a91db4d9129b589a66cda3f";
          sha256 = "sha256-JC4jYJXSXyjaYtgH+Og8MhP8LfM/2gVx1EEDwEDFyQo=";
        };
      };
    in
      with pkgs.vimPlugins; [
        vim-tidal
        vim-nix
        vim-surround
        tokyonight-nvim
        vim-commentary
        vim-easymotion
        denops-vim
        {
          plugin = skkeleton;
          config = ''
            function! s:skkeleton_init() abort
              call skkeleton#config({
                \ 'eggLikeNewline': v:true,
                \ 'globalJisyo': '${pkgs.skk-dicts}/share/SKK-JISYO.combined',
                \ 'globalJisyoEncoding': 'utf-8'
                \ })
              call skkeleton#register_kanatable('rom', {
                \ "z\<Space>": ["\u3000", '''],
                \ })
              imap <C-j> <Plug>(skkeleton-toggle)
              cmap <C-j> <Plug>(skkeleton-toggle)
            endfunction
            augroup skkeleton-initialize-pre
              autocmd!
              autocmd User skkeleton-initialize-pre call s:skkeleton_init()
            augroup END

            imap <C-j> <Plug>(skkeleton-toggle)
            cmap <C-j> <Plug>(skkeleton-toggle)
          '';
        }
      ];
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-skk
        # (libsForQt5.callPackage ./pkgs/fcitx5-skk.nix { })
      ];
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
