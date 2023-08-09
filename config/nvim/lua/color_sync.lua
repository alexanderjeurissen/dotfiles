local vim = vim or {}

if vim.o.background == 'dark' then
  os.execute("sed -i.bak 's/\\*solarized_light/*solarized_dark/g' ~/.dotfiles/config/alacritty/alacritty.yml")
elseif vim.o.background == 'light' then
  os.execute("sed -i.bak 's/\\*solarized_dark/*solarized_light/g' ~/.dotfiles/config/alacritty/alacritty.yml")
end
