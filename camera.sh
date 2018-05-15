#This is a simple bash script if you're operating a built-in camera for a Raspberry Pi
# !/bin/bash

i=0
k=-30
while [ $i -lt 6 ]
do
        echo "Taking Images"
        raspistill -vf -hf -w 1280 -h 720 -br 45 -o img$((i+1)).jpg
        echo "Image "$((i+1))" taken!"
        sleep 2
        if [ $i -eq 5 ]; then
                echo "Cropping img$((i+1))"
                mogrify -gravity East -crop 60%x+0 img$((i+1)).jpg
        fi
        i=$((i+1))
done

./stitching img1.jpg img2.jpg img3.jpg img4.jpg img5.jpg
convert panorama.jpg img6.jpg +append panorama.jpg

new_image=annotated.bmp

echo "Converting Image from JPG to BMP"
convert panorama.jpg -fill black -gravity Southwest -pointsize 30 -resize 'x320' $new_image

echo "Finding dimensions of image"

W=$(identify -format '%w' $new_image) #width

fourth=$((W/4))
half=$((W/2))
threefourths=$((3*W/4))

echo "Annotating Image"
mogrify \
        -fill white \
        -gravity Southwest \
        -pointsize 30 \
        -annotate +120+0 'North' \
        -annotate +$((fourth+110))+0 'East' \
        -annotate +$((half+100))+0 'South' \
        -annotate +$((threefourths+100))+0 'West' \
        $new_image

mogrify \
        -fill white \
        -gravity Northwest \
        -pointsize 30 \
        -type truecolor \
        -annotate +$((W*X/36))+0 '|' \
        $new_image

ten_deg_px=$((W/36))
for j in $(seq 0 36); do
        px_pos=$((j*ten_deg_px))
        m=$(((j*10)+k))
        while [ $m -lt 0 ]; do
                m=$((m+360)); done
        while [ $m -gt 360 ]; do
                m=$((m-360)); done
        mogrify \
                -fill white \
                -gravity Northwest \
                -pointsize 30 \
                -type truecolor \
                -annotate +$px_pos+0 '|' \
                -pointsize 15 \
                -annotate +$((px_pos-20))+30 $m \
                $new_image
done

xdg-open $new_image
