#!/bin/sh

_help () {
    echo 'Usage: spotato [play|pause|toggle|next|previous|mediaplayer]'
    echo '\nThese are the common Spotato commands uses:\n'
    echo 'Play and stop the music'
    echo '\tplay\tIf the music is stopped then unstop it'
    echo '\tpause\tIf the music is running then stop it'
    echo '\ttoggle\tIf the music is stopped this unstop it,'
    echo '\t\tif the music is running than stop it'
    echo ''
    echo 'Change the music'
    echo '\tnext\tGo to the next track'
    echo '\tprevious\tReturn to the previous track'
    echo ''
    echo 'Change the music'
    echo '\tmediaplayer\tChoose the mediaplayer to use'
    echo '\tmediaplayer <option>\tSet mediaplayer to use'
}

_set_mediaplayer () {
    echo $1 > ~/.config/spotato/mediaplayer
}

_choose_mediaplayer () {
    echo 'Mediaplayer in use: '$mediaplayer
    echo '  ---> What media player do you want to use?'
    echo '   1) Spotify'
    echo '   2) Headset'
    echo '   3) Nuclear'
    echo '   4) Chromium'
    echo 'If not in the list you can type your mediaplayer'
    read -p '  ---> Type selection: ' key
    case $key in
    	4)
             	mediaplayer=$( dbus-send --print-reply --dest=org.freedesktop.DBus  /org/freedesktop/DBus org.freedesktop.DBus.ListNames | grep chromium | awk -F ' ' '/string/ {print $2}' | cut -c25- | rev | cut -c2- | rev)
            ;;
    	3)
    		mediaplayer=Nuclear_Music_Player
    	;;
    	2)
    		mediaplayer=headset
    	;;
    	1)
    		mediaplayer=spotify
    	;;
    	*)
    		mediaplayer=$key
    	;;
    esac
    _set_mediaplayer $mediaplayer
    echo 'New mediaplayer: '$mediaplayer
}


mediaplayer=$(head -n 1 ~/.config/spotato/mediaplayer)

if [ $# -eq 0 ] ;
then
	echo ' THIS IS SPOTATO '
	echo 'Manage mediaplayer with potato'
	echo '********************************'
        _help
        exit 1
fi

case "$1" in
    mediaplayer)
        if [ $# -eq 1 ] ; 
        then
            _choose_mediaplayer
        elif [ $# -eq 2 ] ; 
        then
            _set_mediaplayer $2
        fi
        ;;
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
    help)
        _help
        ;;
    *)
        echo "Spotato: '"$1"' is not a spotato command. See 'spotato help'"
esac

exit 0
