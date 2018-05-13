#This is a simple bash script if you're operating a built-in camera for a Raspberry Pi 
#!/bin/bash 
 
i=0
k=-30
while [ $i -lt 6 ] 
do 
        raspistill -vf -hf -w 1280 -h 720 -br 45 -o img$((i+1)).jpg 
        echo "Image "$((i+1))" taken!" 
        sleep 2 
        i=$((i+1)) 
done 
 
echo "Cropping Image6" 
convert img6.JPG -crop 60%x+0 006.JPG 
 
./stitching img*
 
echo "Finding dimensions of image" 
 
W=$(identify -format '%w' panorama.jpg) #width 
 
fourth=$((W/4)) 
half=$((W/2)) 
threefourths=$((3*W/4)) 
 
echo "Annotating Image" 
        mogrify\ 
                        -fill white \ 
                        -gravity Southwest \ 
                        -pointsize 30 \ 
                        -annotate +0+0 'North' \ 
                        -annotate +$fourth+0 'East' \ 
                        -annotate +$half+0 'South' \ 
                        -annotate +$threefourths+0 'West'\ 
                        panorama.jpg 
 
        mogrify \ 
                        -fill white \ 
                        -gravity Northwest \ 
                        -pointsize 30 \ 
                        -type truecolor \ 
                        -annotate +$((W*X/36))+0 '|' \ 
                        panorama.jpg
ten_deg_px=$((W/36)) 
for j in $(seq 0 36); do 
        px_pos=$((j*ten_deg_px))
        m=$(((j*10)+k))
        while [ $m -lt 0 ]; do
                m=$((m+360)); done
        while [ $m -gt 360 ]; do
                m=$((m-360)); done
        mogrify\ 
                        -fill white \ 
                        -gravity Northwest \ 
                        -pointsize 30 \ 
                        -type truecolor \ 
                        -annotate +$px_pos+0 '|' \ 
                        -pointsize 15 \ 
                        -annotate +$((px_pos-20))+30 $m \ 
                        panorama.jpg 
done 

xdg-open panorama.jpg
