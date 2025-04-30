{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "albinlju-packages";
      paths = [
        zsh-completions
        (neovim.overrideAttrs (oldAttrs: { version = "0.10.4"; src = oldAttrs.src; }))
        dwt1-shell-color-scripts
        pure-prompt
        starship
        nodejs
        tmux
        fd
        ripgrep
        fzf
        lazygit
        ascii-image-converter
      ];
    };
  };
}
