#This is a simple bash script if you're operating a built-in camera for a Raspberry Pi
#!/bin/bash

i=0
while [ $i -lt 8 ]
do
        raspistill -w 480 -h 320 -o img$((i+1)).jpg
        echo "Image "$((i+1))" taken!"
        sleep 2
        i=$((i+1))
done

./stitching img*
