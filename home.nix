{ config, pkgs, inputs, ... }:

let
  my-python-packages = pypkgs: with pypkgs; [
    pandas
    # jupyterlab
    openpyxl
    online-judge-tools
    pwntools
  ];

in

{
  nix.package = pkgs.nix;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    # trusted-users = ["zer0-star"];
  };

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./modules/sway.nix
    ./modules/sway/waybar.nix
    ./modules/pipewire.conf.nix
  ];

  nixpkgs.overlays = [
    inputs.tidal.overlays.default
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "zer0-star";
  home.homeDirectory = "/home/zer0-star";

  home.packages = with pkgs; [
    cachix

    pciutils
    usbutils
    lshw
    xdg-utils
    libinput

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

    rnnoise-plugin

    aria2
    wget
    exa
    fd
    du-dust
    ripgrep ripgrep-all
    neofetch
    # gh
    ffmpeg
    imagemagick
    zip
    unzip
    file
    mimeo
    mold
    yt-dlp
    speedtest-cli
    pandoc
    gdb
    docker
    docker-compose
    bat
    lazygit
    mysql-client
    p7zip
    # (pkgs.callPackage ./pkgs/imhex.nix {})
    nodePackages.gitmoji-cli

    diesel-cli

    supercollider

    yubioath-desktop

    obs-studio
    obs-studio-plugins.obs-websocket
    obs-studio-plugins.wlrobs

    (python3.withPackages my-python-packages)
    nodejs_latest
    # npm
    deno
    nim
    stack
    haskell-language-server
    cmake
    extra-cmake-modules
    gcc
    satysfi
    rustc
    rustfmt
    cargo
    clippy
    rust-analyzer
    # rust-analyzer-nightly
    go
    koka
    purescript
    # (pkgs.callPackage ./pkgs/mint.nix {})
    # (pkgs.callPackage ./pkgs/ante {})

    texlive.combined.scheme-full

    citra

    gnumake
    gnutar

    firefox
    thunderbird
    bitwarden
    bitwarden-cli
    gimp

    polymc

    # fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-cjk-sans
    noto-fonts-emoji
    noto-fonts-extra
    (nerdfonts.override { fonts = [ "VictorMono" "Cousine" "DejaVuSansMono" ]; })
    roboto
    source-han-sans
    source-han-serif
    source-han-mono

    #unfree
    unityhub
    minecraft
    discord
    (vivaldi.override {
      proprietaryCodecs = true;
      enableWidevine = true;
    })
    spotify
    zoom-us
    (pkgs.callPackage ./pkgs/inkdrop.nix { })
    notable
    slack
    tor-browser-bundle-bin
    postman
  ];

  home.shellAliases = {
    l = "exa -lah --icons";
    homeswitch = "home-manager switch --flake \"$HOME/nix-home#zer0-star\" --impure";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.sessionPath = [
    "$HOME/.cargo/bin"
    "$HOME/.nimble/bin"
    "$HOME/.local/bin"
  ];

  fonts.fontconfig.enable = true;

  programs.opam.enable = true;

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "https";
      prompt = "enabled";
    };
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
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
      prompt.theme = "paradox";
      pmodules = [
        "environment"
        "terminal"
        "editor"
        "history"
        "directory"
        "spectrum"
        "utility"
        "completion"
        "prompt"
        "git"
        "haskell"
      ];
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.7;
    };
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      ms-vscode.cpptools
      github.copilot
      haskell.haskell
      matklad.rust-analyzer
      # matklad.rust-analyzer-nightly
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
      key = "71F4DFBF21CC954902B59DCAE87C336DA57DE88F";
      signByDefault = true;
    };

    extraConfig = {
      # credential.helper = "store";
      core.editor = "nvim";
      init.defaultBranch = "main";
    };
  };

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
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

  programs.neovim = {
    enable = true;

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
      skkeleton =
        pkgs.vimUtils.buildVimPluginFrom2Nix {
          name = "skkeleton";
          src = pkgs.fetchFromGitHub {
            owner = "vim-skk";
            repo = "skkeleton";
            rev = "79c703865707984761f379870dd3a7522ac5ef04";
            sha256 = "sha256-gAJl9BX//QDP1TO7uo8c/LooKgeST73CmecAnVfIFK4=";
          };
        };
      denops-vim =
        pkgs.vimUtils.buildVimPluginFrom2Nix {
          name = "denops-vim";
          src = pkgs.fetchFromGitHub {
            owner = "vim-denops";
            repo = "denops.vim";
            rev = "53f25d7f2d20c7064a91db4d9129b589a66cda3f";
            sha256 = "sha256-JC4jYJXSXyjaYtgH+Og8MhP8LfM/2gVx1EEDwEDFyQo=";
          };
        };
    in with pkgs.vimPlugins; [
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
              \ 'globalJisyo': '${ pkgs.skk-dicts }/share/SKK-JISYO.combined',
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
        (libsForQt5.callPackage ./pkgs/fcitx5-skk.nix { })
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
