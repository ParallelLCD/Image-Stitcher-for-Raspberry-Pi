# Image-Stitcher-for-Microcontrollers

Requirments:
-----------
[OpenCV](https://opencv.org/)

Information:
-----------
This is a C++ program used to stitch images into a panorama. Uses [cv::Stitcher](https://docs.opencv.org/3.4.0/d2/d8d/classcv_1_1Stitcher.html) library with the code being derived from the [stitching tutorial](https://docs.opencv.org/3.4.0/d8/d19/tutorial_stitcher.html) from OpenCV documentation. Code is modified to be designed for microcontrollers (e.g. Raspberry Pi), but can be compiled on any device with OpenCV installed. This is also modified to display a window after the stitching process is done.

Instructions:
------------
Linux:
Makefile is made using the command "cmake ." and the stitching file is compiled using the "make" command.
The file have to take argument commands to input image. Enter "./stitching filename1.jpg filename2.jpg filename3.jpg..." with 'filename' being the name of your image file.

Windows:
lol, idk pls don't ask. Download Visual Studio or something and figure it out yourself.

Error Codes:
-----------
* 0 = OK: Images are sucessfully sitiched, although you won't see this error code since it's not an error.
* 1 = ERR_NEED_MORE_IMGS: Need more images. Why are you are you using this program when you're just stitching one image you idiot.
* 2 = ERR_HOMOGRAPHY_EST_FAIL: Images stacked on each other are not compatiable. No, you can't have your limbs in funny places with this program.	
* 3 = ERR_CAMERA_PARAMS_ADJUST_FAIL: One or more images can't decide where to be placed in the panorama. You can blame OpenCV for being stupid if you encounter this error.

Known Bugs:
----------
* In some cases, the stitching program could take a long time to process, depending on the amount of images and the processor speed of your device. This is especially the case when trying to stitch a full 360 degree image, since the final image in the stack can't decide to be in beginning or end of the panorama. Either the resulting image will be offseted, or the program gives up and outputs an Error Code: 3.   
