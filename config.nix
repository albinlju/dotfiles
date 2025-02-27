{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "mischa-tools";
      paths = [
        zsh-completions
        neovim
        nodejs_22
        pure-prompt
        fd
        ripgrep
        fzf
        lazygit
        k9s
      ];
    };
  };
}