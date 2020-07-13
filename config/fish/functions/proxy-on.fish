# Defined in - @ line 1
function proxy-on --wraps=sudo\ networksetup\ -setsecurewebproxy\ \'Wi-Fi\'\ 127.0.0.1\ 12345\ \&\&\ sudo\ networksetup\ -setwebproxy\ \'Wi-Fi\'\ 127.0.0.1\ 12345 --description alias\ proxy-on=sudo\ networksetup\ -setsecurewebproxy\ \'Wi-Fi\'\ 127.0.0.1\ 12345\ \&\&\ sudo\ networksetup\ -setwebproxy\ \'Wi-Fi\'\ 127.0.0.1\ 12345
  sudo networksetup -setsecurewebproxy 'Wi-Fi' 127.0.0.1 12345 && sudo networksetup -setwebproxy 'Wi-Fi' 127.0.0.1 12345 $argv;
end
