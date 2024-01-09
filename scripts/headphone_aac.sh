#!/usr/bin/env sh

defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Max (editable)" 80;
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" 80;
defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool (editable)" 80;
defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool" 80;
defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Max" 80;
defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Min" 80;
defaults write com.apple.BluetoothAudioAgent "Stream - Flush Ring on Packet Drop (editable)" 0;
defaults write com.apple.BluetoothAudioAgent "Stream - Max Outstanding Packets (editable)" 16;
defaults write com.apple.BluetoothAudioAgent "Stream Resume Delay" "0.75"

defaults write bluetoothaudiod "Enable AAC codec" -bool true
defaults write bluetoothaudiod "Enable AptX codec" -bool false
defaults write bluetoothaudiod "AAC Bitrate" -int 320
defaults write bluetoothaudiod "AAC max packet size" -int 644

sudo pkill bluetoothd