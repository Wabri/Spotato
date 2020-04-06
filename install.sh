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
	if [ -z $mediaplayer ] 
	then
		mediaplayer=spotify
	fi
	echo '  ---> What media player do you want to use? (you can change even after installation)'
	echo '   Default mediaplayer: '$mediaplayer
	read -p '  ---> Press enter or type the mediaplayer you want to controll: ' key
	case $key in
		'')
			;;
		*)
			mediaplayer=$key
			;;
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

