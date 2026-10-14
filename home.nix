{
  config,
  pkgs,
  inputs,
  overlays,
  ...
}:
let
  my-python =
    (pkgs.python3.override {
      packageOverrides = pyfinal: pyprev: {
        ptrlib = pyfinal.callPackage ./pkgs/ptrlib { };
        # pdf2zh = pyfinal.callPackage ./pkgs/pdf2zh { };
      };
    }).withPackages
      my-python-packages;

  my-python-packages =
    pypkgs: with pypkgs; [
      ptrlib
      # pdf2zh

      pandas
      numpy
      matplotlib
      tqdm
      jupyterlab
      scikit-image
      scikit-learn
      openpyxl
      pwntools
      pyyaml
      bibtexparser
      # (pypkgs.callPackage ./pkgs/wayremap {})
      pyclip
      torch
      pygments
      pycryptodome
      selenium
      polars
      pulp
    ];

  obs-wl = pkgs.writeScriptBin "obs-wl" ''
    exec ${config.programs.obs-studio.finalPackage}/bin/obs -platform xcb
  '';

in
{
  nix.package = pkgs.nixVersions.latest;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    # keep-outputs = true;
    # keep-derivations = true;
    cores = 0;
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
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

  nixpkgs.overlays = overlays ++ [ ];

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
    pympress
    pavucontrol
    nomacs
    wl-mirror
    thorium-reader
    obs-wl
    # steam-gs

    rnnoise-plugin

    aria2
    wget
    eza
    fd
    dust
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
    unzipNLS
    file
    mimeo
    mold
    yt-dlp
    speedtest-cli
    pandoc
    gdb
    pwndbg
    valgrind
    docker
    docker-compose
    bat
    lazygit
    mariadb.client
    p7zip-rar
    # (pkgs.callPackage ./pkgs/imhex.nix {})
    imhex
    gitmoji-cli
    ngrok
    cloudflared
    pwncat
    jadx
    socat
    john
    rockyou
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
    # stegseek
    # binwalk
    rlwrap
    zbar
    zxing
    inetutils
    iputils
    dig
    doggo
    tokei
    kaggle
    hugo
    gotmplfmt
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
    just
    hyperfine
    sd
    # zenn-cli
    nix-prefetch-github
    gemini-cli
    tree-sitter
    online-judge-tools
    online-judge-verify-helper
    perf

    # (libsForQt5.callPackage ./pkgs/libtas { })
    # (libsForQt5.callPackage ./pkgs/med { })

    supercollider

    yubioath-flutter
    yubikey-manager

    (lib.lowPrio my-python)
    # pypy3
    rye
    uv
    ruff
    # nodejs_latest
    nodejs
    # corepack
    # npm
    deno
    bun
    biome
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
    meson
    ninja
    gcc_latest
    boost.dev
    clang-tools
    ocaml
    satysfi
    # TODO: fix
    # (callPackage ./pkgs/satysfi-language-server { })

    # rustc
    # rustfmt
    # cargo
    # clippy
    # rust-analyzer
    # rust-analyzer-nightly
    rustup
    cargo-expand
    cargo-tauri
    trunk
    go
    gopls
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
    scala-cli
    jdk21
    kubectl
    k3d
    kustomize
    nasm
    nixd
    alejandra
    nixfmt
    deadnix
    statix
    julia
    # isabelle
    uiua
    kotlin

    # texlive.combined.scheme-full
    texliveFull
    tex-fmt
    texlab

    # citra

    # zotero
    inkscape

    gnumake
    gnutar

    firefox
    thunderbird
    # betterbird
    # bitwarden-desktop
    bitwarden-cli
    gimp3
    gof5
    # logseq
    libreoffice
    onlyoffice-desktopeditors
    wireshark
    ghidra-bin

    # (callPackage ./pkgs/track-cli {})

    prismlauncher
    tetrio-desktop
    # lutris

    # fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.victor-mono
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.cousine
    # (nerdfonts.override {fonts = ["VictorMono" "Cousine" "DejaVuSansMono"];})
    roboto
    roboto-slab
    source-han-sans
    source-han-serif
    source-han-code-jp
    # kanit-font
    (callPackage ./pkgs/cica { })
    (callPackage ./pkgs/juisee { })
    (callPackage ./pkgs/juisee/nerdfont.nix { })
    monaspace
    (callPackage ./pkgs/firple { })

    #unfree
    # unityhub
    # (pkgs.callPackage ./pkgs/unityhub {})
    # minecraft
    # (discord.override {
    #   withMoonlight = true;
    #   moonlight = inputs.moonlight.packages.${pkgs.system}.moonlight;
    # })
    claude-code
    codex
    equibop
    (vivaldi.override {
      proprietaryCodecs = true;
      # enableWidevine = true;
    })
    google-chrome
    # vivaldi-ffmpeg-codecs
    # widevine-cdm
    spotify
    zoom-us
    # (pkgs.callPackage ./pkgs/inkdrop.nix { })
    # notable
    slack
    tor-browser
    # postman
    # jetbrains.rider
    parsec-bin
    # (callPackage ./pkgs/parsec { })
    # voicevox
    # voicevox-engine
    # mathematica
  ];

  home.shellAliases = {
    l = "eza -lah --icons auto";
    # homeswitch = "home-manager switch --flake \"$HOME/nix-home#zer0-star\" --impure";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.sessionPath =
    [ ]
    ++ map (p: "${config.home.homeDirectory}" + p) [
      "/.cargo/bin"
      "/.nimble/bin"
      "/.local/bin"
      "/.cabal/bin"
    ];

  fonts.fontconfig = {
    enable = true;
  };

  xdg.configFile."fontconfig/fonts.conf".text = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
    <match target="scan">
        <test name="family">
            <string>Juisee</string>
        </test>
        <edit name="spacing">
            <int>100</int>
        </edit>
    </match>
    </fontconfig>
  '';

  home.pointerCursor = {
    # package = pkgs.nur.repos.ambroisie.volantes-cursors;
    # name = "volantes_light_cursors";
    # name = "volantes_cursors";
    enable = true;
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 64;
    x11.enable = true;
  };

  systemd.user.tmpfiles.rules = [
    "D! %h/tmp 0700"
  ];

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
      name = "Palenight";
      package = pkgs.palenight-theme;
    };
    iconTheme = {
      name = "Nordzy";
      package = pkgs.nordzy-icon-theme;
    };
    gtk4.theme = config.gtk.theme;
    font = {
      name = "Hiragino Kaku Gothic ProN";
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
      homeswitch = "home-manager switch --flake \"~/nix-home#zer0-star\" --impure";
    };
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
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
      kn = {
        position = "anywhere";
        expansion = "&& kitten notify 'done!' || kitten notify 'failed!'";
      };
      mnt = "sudo mount -o uid=(id -u),gid=(id -g)";
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
      # font.size = 12.0;
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

  programs.kitty = {
    enable = true;
    font.name = "Juisee";
    # font.name = "DejaVuSansM Nerd Font Mono";
    font.size = 12;
    themeFile = "Dracula";
    settings = {
      background_opacity = 0.7;
      background_blur = 10;
      cursor_trail = 30;
      touch_scroll_multiplier = 1.5;
    };
    keybindings = {
      "ctrl+c" = "copy_and_clear_or_interrupt";
      "ctrl+v" = "paste_from_clipboard";
      "ctrl+shift+h" = "previous_tab";
      "ctrl+shift+l" = "next_tab";
      "ctrl+shift+p" = "scroll_to_prompt -1";
      "ctrl+shift+n" = "scroll_to_prompt 1";
      "ctrl+alt+t" = "new_tab_with_cwd";
    };
  };

  programs.nh = {
    enable = true;
  };

  programs.nix-index = {
    enable = true;
    # enableFishIntegration = false;
  };

  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
  };

  services.udiskie = {
    enable = true;
    settings = {
      # workaround for
      # https://github.com/nix-community/home-manager/issues/632
      program_options = {
        # replace with your favorite file manager
        file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
      };
    };
  };

  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      mpris
      youtube-chat
      (buildLua {
        pname = "pause-replay";
        version = "0.0.0";
        src = ./etc/mpv-scripts/pause-replay;

        scriptPath = ".";
      })
    ];
    bindings = rec {
      SPACE = "script-message pause-replay";
      k = SPACE;
      w = "add speed -.01";
      e = "add speed .01";
      s = "add speed -.1";
      d = "add speed .1";
      g = "set speed 2.0";
      h = "set speed 2.5";
      r = "set speed 1.0";
      j = "seek -10";
      l = "seek 10";
    };
    config = {
      keep-open = true;
      # loop-file = true;
    };
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
    ];
  };

  programs.mangohud = {
    enable = true;
    settings = {
      toggle_hud = "F12";
    };
  };

  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    profiles.default.extensions =
      let
        extensions = pkgs.nix-vscode-extensions.vscode-marketplace-release;
      in
      with extensions;
      [
        extensions."42crunch".vscode-openapi
        extensions."8amjp".charactercount
        asvetliakov.vscode-neovim
        banacorn.agda-mode
        bbenoist.nix
        biomejs.biome
        budparr.language-hugo-vscode
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        charliermarsh.ruff
        cocopon.iceberg-theme
        cweijan.dbclient-jdbc
        cweijan.vscode-mysql-client2
        davidanson.vscode-markdownlint
        dbaeumer.vscode-eslint
        denoland.vscode-deno
        dhall.dhall-lang
        eamodio.gitlens
        enkia.tokyo-night
        esbenp.prettier-vscode
        github.vscode-github-actions
        github.vscode-pull-request-github
        gohugoio.gotmplfmt
        golang.go
        gruntfuggly.todo-tree
        haskell.haskell
        haskell.language-haskell
        hbenl.vscode-test-explorer
        humao.rest-client
        icrawl.discord-vscode
        james-yu.latex-workshop
        koka.language-koka
        leanprover.lean4
        marp-team.marp-vscode
        mathiasfrohlich.kotlin
        mint-lang.mint
        mkhl.direnv
        ms-azuretools.vscode-containers
        ms-python.debugpy
        ms-python.python
        ms-python.vscode-pylance
        ms-python.vscode-python-envs
        ms-toolsai.jupyter
        ms-toolsai.jupyter-keymap
        ms-toolsai.jupyter-renderers
        ms-toolsai.vscode-jupyter-cell-tags
        ms-toolsai.vscode-jupyter-slideshow
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-ssh-edit
        ms-vscode.cmake-tools
        ms-vscode.cpp-devtools
        ms-vscode.cpptools
        ms-vscode.cpptools-extension-pack
        ms-vscode.cpptools-themes
        ms-vscode.hexeditor
        ms-vscode.makefile-tools
        ms-vscode.remote-explorer
        ms-vscode.test-adapter-converter
        ms-vsliveshare.vsliveshare
        nimsaem.nimvscode
        nwolverson.ide-purescript
        nwolverson.language-purescript
        openai.chatgpt
        pickoba.satysfi-workshop
        redhat.vscode-yaml
        rust-lang.rust-analyzer
        scala-lang.scala
        scalameta.metals
        stylelint.vscode-stylelint
        sumneko.lua
        tamasfe.even-better-toml
        tauri-apps.tauri-vscode
        thuliteio.hugo-shortcodes
        tomoki1207.pdf
        uiua-lang.uiua-vscode
        unifiedjs.vscode-mdx
        usernamehw.errorlens
        vscode-icons-team.vscode-icons
        vue.volar
        yzhang.markdown-all-in-one
        zokugun.explicit-folding
      ];
  };

  programs.difftastic = {
    enable = true;
    git.enable = true;
  };

  programs.git = {
    enable = true;

    signing = {
      format = "openpgp";
      key = "9009FF60684DBF542B8F84DA5AF0540F8ADAD765";
      signByDefault = true;
    };

    lfs.enable = true;

    settings = {
      user.name = "zer0-star";
      user.email = "zer0star.65535@gmail.com";

      alias = {
        pushforce = "push --force-with-lease --force-if-includes";
      };

      # credential.helper = "store";
      core.editor = "nvim";
      init.defaultBranch = "main";
      pull.ff = "only";

      column.ui = "auto";
      branch.sort = "-committerdate";
      tag.sort = "version:refname";
      diff = {
        algorithm = "histogram";
        colorMoved = "zebra";
        mnemonicPrefix = true;
        renames = true;
      };
      push = {
        followTags = true;
        default = "simple";
        autoSetupRemote = true;
      };
      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };
      help.autocorrect = "prompt";
      commit.verbose = true;
      rerere = {
        enabled = true;
        autoupdate = true;
      };
      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };
      core = {
        fsmonitor = true;
        untrackedCache = true;
      };
      merge.conflictstyle = "zdiff3";
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
    pinentry.package = pkgs.pinentry-curses;
  };

  programs.ssh = {
    enable = true;
    includes = [ "secret.conf" ];
    enableDefaultConfig = false;
    settings = {
      "*" = {
        forwardAgent = true;
      };
      "git.trap.jp" = {
        HostkeyAlgorithms = "+ssh-rsa";
        PubkeyAcceptedAlgorithms = "+ssh-rsa";
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

    plugins =
      let
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
      with pkgs.vimPlugins;
      [
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
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons =
        let
          dict = pkgs.callPackage ./pkgs/merged-dict { };
        in
        with pkgs;
        [
          fcitx5-mozc
          (fcitx5-skk.overrideAttrs (
            _final: _prev: {
              cmakeFlags = [
                (pkgs.lib.cmakeBool "ENABLE_QT" false)
                "-DSKK_PATH=${dict}/share/skk"
              ];
            }
          ))
          # (libsForQt5.callPackage ./pkgs/fcitx5-skk.nix { })
        ];
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
    config = {
      common.default = "wlr";
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
