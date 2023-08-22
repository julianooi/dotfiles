#! /usr/bin/zsh
# runs rtx vpn in a new tmux session

config_path='~/Development/rtx'
session_name='rtx-vpn'
config_file='client.ovpn'
auth_file='vpn.auth'
tmux new-session -d -s $session_name "sudo openvpn --config $config_path/client.ovpn --auth-user-pass $config_path/vpn.auth"
tmux switchc -t $session_name

