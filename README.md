```sh
brew install ngrok
brew install neovim
brew install alacritty
brew tap homebrew/cask-fonts
brew install --cask font-fira-code
brew search '/font-.*-nerd-font/' | awk '{ print $1 }' | xargs -I{} brew install --cask {} || true
brew install tree-sitter
brew install tmuxp
npm install -g @fsouza/prettierd
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
brew install fd
brew install ripgrep
:Copilot setup
```
