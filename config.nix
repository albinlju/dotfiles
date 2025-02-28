{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "albinlju-packages";
      paths = [
        zsh-completions
        neovim
        nodejs_22
        pure-prompt
        fd
        ripgrep
        fzf
        lazygit
        roslyn-ls
      ];
    };
  };
}
