# Defined in - @ line 1
function proxy-off --wraps=sudo\ networksetup\ -setsecurewebproxystate\ \'Wi-Fi\'\ off\ \&\&\ sudo\ networksetup\ -setwebproxystate\ \'Wi-Fi\'\ off --description alias\ proxy-off=sudo\ networksetup\ -setsecurewebproxystate\ \'Wi-Fi\'\ off\ \&\&\ sudo\ networksetup\ -setwebproxystate\ \'Wi-Fi\'\ off
  sudo networksetup -setsecurewebproxystate 'Wi-Fi' off && sudo networksetup -setwebproxystate 'Wi-Fi' off $argv;
end
