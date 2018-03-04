#This is a simple bash script if you're operating a built-in camera for a Raspberry Pi
#!/bin/bash

i=0
while [ $i -lt 6 ]
do
        raspistill -w 1280 -h 720 -o $((i+1)).jpg
        echo "Image taken!"
        sleep 3
        i=$((i+1))
done

./stitching 1.jpg 2.jpg 3.jpg 4.jpg 5.jpg 6.jpg
