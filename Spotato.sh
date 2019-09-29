#!/bin/bash

mediaplayer=$(cat ~/.config/spotato/mediaplayer)

case "$1" in
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
   		echo 'Usage: spotato {play|pause|toggle|next|previous}'
		exit 2

esac

exit 0
