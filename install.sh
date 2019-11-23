#!/bin/sh

_install_spotato() {
	cp Spotato.sh spotato
	sudo chmod +x spotato
	sudo mv spotato /usr/bin/spotato
}

_create_configuration() {
	mkdir -p ~/.config/spotato
	touch ~/.config/spotato/mediaplayer
}

_setting_up() {
	mediaplayer=$(head -n 1 ~/.config/spotato/mediaplayer)
	echo '  ---> What media player do you want to use?'
	echo '   1) Spotify (default)'
	echo '   2) Headset'
	read -p '  ---> Type selection number: ' key
	case $key in
		2)
			mediaplayer=headset
		;;
		1|*)
			mediaplayer=spotify
	esac
	echo $mediaplayer > ~/.config/spotato/mediaplayer
}

echo '******************************************'
echo '---> Planting spotatoes on /usr/local/bin'
_install_spotato
echo '******************************************'
echo '---> Barn construction on .config/spotato/'
_create_configuration
echo '******************************************'
echo '---> Extracting the right spotato'
_setting_up
echo '******************************************'
echo '---> Let the music play with spotato'


