#!/bin/sh

mediaplayer=$(head -n 1 ~/.config/spotato/mediaplayer)

if [ $# -eq 0 ] ;
then
	echo ' THIS IS SPOTATO '
	echo 'Manage mediaplayer with potato'
	echo '********************************'
fi

case "$1" in
	mediaplayer)
		echo 'Mediaplayer in use: '$mediaplayer
		echo '  ---> What media player do you want to use?'
		echo '   1) Spotify'
		echo '   2) Headset'
		read -p '  ---> Type selection: ' key
		case $key in
			2)
				mediaplayer=headset
			;;
			1|*)
				mediaplayer=spotify
		esac
		echo $mediaplayer > ~/.config/spotato/mediaplayer
    play)
		dbus-send --print-reply --dest=org.mpris.MediaPlayer2.$mediaplayer /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Play
	;;
    pause)
   		dbus-send --print-reply --dest=org.mpris.MediaPlayer2.$mediaplayer /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause
   	;;
    toggle)
		dbus-send --print-reply --dest=org.mpris.MediaPlayer2.$mediaplayer /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
   	;;
    next)
		dbus-send --print-reply --dest=org.mpris.MediaPlayer2.$mediaplayer /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next
   	;;
    previous)
		dbus-send --print-reply --dest=org.mpris.MediaPlayer2.$mediaplayer /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous
   	;;
    *)
   		echo 'Usage: spotato [play|pause|toggle|next|previous]'
esac

exit 0
