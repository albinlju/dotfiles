if [ -r ~/.bashrc ]; then
  source ~/.bashrc
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
  export BASH_SILENCE_DEPRECATION_WARNING=1
fi

export XDG_CONFIG_HOME="$HOME"/.config
