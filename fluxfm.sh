kill $(pidof madplay)
wget -O - http://www.fluxfm.de/stream-bremen | madplay - -A+5
