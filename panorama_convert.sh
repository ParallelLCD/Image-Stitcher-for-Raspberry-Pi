#!/bin/bash
#echo "Converting into panorama"
#convert img*.jpg +append panorama.jpg

#python usercode

img_annotate()
{
        a=$1
        b=$2
        mogrify\
                -fill white \
                -gravity Northwest \
                -pointsize 30 \
                -type truecolor \
                -annotate +$((px_pos-a))+0 '|' \
                -pointsize 15 \
                -annotate +$((px_pos-b))+30 $m \
                $new_image
}

i=0
k=-30
#dec="5.4"
while [ $i -lt 6 ]; do
        old_image=img$((i+1)).jpg
        new_image=annotated$((i+1)).bmp

        echo "Converting Image"$((i+1))" from JPG to BMP file"
        convert $old_image -fill black -gravity Southwest -pointsize 30 -resize 'x320' $new_image

        echo "Finding dimensions of image"

        W=$(identify -format '%w' $new_image) #width

        fourth=$((W/4))
        half=$((W/2))
        threefourths=$((3*W/4))
		echo "Annotating Image"
		if [ $i -eq 0 ]; then
        mogrify\
                -fill white \
                -gravity Southwest \
                -pointsize 30 \
                -annotate +$((half-50))+0 'North' \
                $new_image
        elif [ $i -eq 2 ]; then
        mogrify\
                -fill white \
                -gravity Southwest \
                -pointsize 30 \
                -annotate +0 'East' \
                $new_image
        elif [ $i -eq 3 ]; then
        mogrify\
                -fill white \
                -gravity Southwest \
                -pointsize 30 \
                -annotate +$((half-50))+0 'South'\
                $new_image
        elif [ $i -eq 5 ]; then
        mogrify\
                -fill white \
                -gravity Southwest \
                -pointsize 30 \
                -annotate +0 'West' \
                $new_image
        fi
        ten_deg_px=$((W/6))
        for j in $(seq 0 5); do
                px_pos=$((j*ten_deg_px))
                m=$(((j*10)+k))
                while [ $m -lt 0 ]; do
					m=$((m+360)); done
                while [ $m -gt 360 ]; do
					m=$((m-360)); done
                img_annotate $60 $80
        done
        #if [ $i -eq 5 ]; then
                #echo "Cropping Image"$((i+1))
                #convert $new_image -crop 20%x+0 $new_image
        #fi
        i=$((i+1))
        k=$((k+60))
done

echo "Converting into panorama"
convert annotated* +append panorama.bmp

xdg-open panorama.bmp

exit

