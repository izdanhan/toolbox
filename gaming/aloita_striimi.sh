#!/bin/bash

# Etsitään Canon EOS R50 laitepolku (yleensä /dev/video0, mutta voi vaihdella)
# Etsitään laite nimen perusteella
KAMERA=$(v4l2-ctl --list-devices | grep -A 1 "Canon EOS R50" | grep /dev/video | awk '{print $1}')

if [ -z "$KAMERA" ]; then
    echo "⚠️  Hups! Canon EOS R50 ei löytynyt. Tarkista USB-kaapeli."
else
    echo "📸 Kamera löytyi: $KAMERA"
    echo "⚙️  Optimoidaan asetukset..."
    
    # Asetetaan kamera käyttämään MJPEG-pakkausta ja 30fps (tai 60fps jos tuettu)
    # Tämä varmistaa, että USB-kaista riittää ja kuva on sulava
    v4l2-ctl -d $KAMERA --set-fmt-video=width=1920,height=1080,pixelformat=MJPG
    v4l2-ctl -d $KAMERA --set-parm=30
fi

echo "🚀 Käynnistetään OBS Studio..."
# Käynnistetään OBS ja palautetaan terminaali vapaaksi
obs &
