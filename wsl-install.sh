sudo bash -c 'echo -e "[network]
generateResolvConf = false" > /etc/wsl.conf
rm /etc/resolv.conf
echo -e "options timeout:1 attempts:1 rotate
nameserver 1.1.1.1
nameserver 1.0.0.1" > /etc/resolv.conf
chattr -f +i /etc/resolv.conf'
#From <https://github.com/microsoft/WSL/issues/5420> 
#https://github.com/nix-community/NixOS-WSL/issues/409#issuecomment-1965580374
