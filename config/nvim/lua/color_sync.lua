local vim = vim or {}

local interfaceStyle = vim.fn.system("defaults read -g AppleInterfaceStyle")

if string.find(interfaceStyle, "Dark") ~= nil then
  vim.o.background = "dark"
  vim.fn.system("sed -i.bak 's/\\*solarized_light/*solarized_dark/g' ~/.dotfiles/config/alacritty/alacritty.yml")
elseif string.find(interfaceStyle, "Dark") == nil then
  vim.o.background = "light"
  vim.fn.system("sed -i.bak 's/\\*solarized_dark/*solarized_light/g' ~/.dotfiles/config/alacritty/alacritty.yml")
end

