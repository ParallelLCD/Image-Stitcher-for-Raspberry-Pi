# Image-Stitcher-for-Raspberry-Pi

Requirments:
-----------
[OpenCV](https://opencv.org/)

Information:
-----------
This is a C++ program used to stitch images into a panorama. Uses the [cv::Stitcher](https://docs.opencv.org/3.4.0/d2/d8d/classcv_1_1Stitcher.html) class with the code being derived from the [stitching tutorial](https://docs.opencv.org/3.4.0/d8/d19/tutorial_stitcher.html) from OpenCV documentation. Code is modified to be designed for any Raspberry Pi model, but can be compiled on any device with OpenCV installed. This is also modified to display a window after the stitching process is done.

Instructions:
------------
Linux:
Makefile can be made using the command "cmake ." and the stitching file can be compiled using the "make" command. The file have to take a series of argument to input the images. Enter "./stitching filename1.jpg filename2.jpg filename3.jpg..." with 'filename' being the name of your image file.

Windows:
lol, idk pls don't ask. Download Visual Studio or something and figure it out yourself.

Error Codes:
-----------
* 0 = OK: Images are successfully stitched, although you won't see this error code since it's not an error.
* 1 = ERR_NEED_MORE_IMGS: Need more images. Why are you are you using this program when you're just stitching one image you idiot.
* 2 = ERR_HOMOGRAPHY_EST_FAIL: Images stacked on each other are not compatible. No, you can't have your limbs in funny places with this program.	
* 3 = ERR_CAMERA_PARAMS_ADJUST_FAIL: One or more images can't decide where to be placed in the panorama. You can blame OpenCV for being stupid if you encounter this error.

Known Bugs:
----------
* In some cases, the stitching program could take a long time to process, depending on the amount of images and the processor speed of your device. This is especially the case when trying to stitch a full 360 degree image, since the final image in the stack can't decide to be in the beginning or end of the panorama due to the corresponding pixels of both ends of that image. Either the resulting image will be offseted, or the program gives up and outputs an Error Code: 3. In case you get an error code, try rearranging the order of the images (sending your first image to the end of the argument list instead). 
