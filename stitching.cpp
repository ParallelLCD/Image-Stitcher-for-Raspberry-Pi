#include <opencv2/core.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/stitching.hpp>
#include <iostream>
#include <string>

using namespace std;
using namespace cv;

//Code is specialized for a microcontroller (e.g. Raspberry Pi)  

bool try_use_gpu = false; //GPU is turned off by default 
Stitcher::Mode mode = Stitcher::PANORAMA; //Stitching mode set to 'PANORAMA' 
vector<Mat> imgs; //Vector to store stack images
string result = "panorama.jpg";
Mat display;

int getImages(int argc, char** argv);

int main(int argc, char* argv[])
{
	int retval = getImages(argc, argv);
	if (retval) return -1; //Program is exited if no images are collected
	
	Mat pan; //Stack of images is called
	Ptr<Stitcher> stitcher = Stitcher::create(mode, try_use_gpu); //Stitcher process is created
    Stitcher::Status status = stitcher->stitch(imgs, pan); //Stitcher is applied to the stack of images 
	
    if (status != Stitcher::OK) //Checks if error persisted during stitching process
    {
        cout << "Can't stitch images, error code = " << int(status) << endl; //Error code (int) can be looked in cv::Stitcher::Status document
        return -1; //Program is exited 
    }
    imwrite(result, pan); //Outputs the panorama into a image file
    cout << "Stitching completed successfully!" << endl;
	
	display = imread(result);
   	namedWindow("Panorama", WINDOW_NORMAL); //Create a window
    imshow( "Panorama", display); //Display panorama in window
    waitKey(0);
	
    return 0;
}

int getImages(int argc, char** argv)
{
    for (int i = 1; i < argc; ++i)
    {
		Mat img = imread(argv[i]); //Vector is called to stack inputed images
        if (img.empty()) //Checks if images are in the vector
        {
            cout << "Can't read image '" << argv[i] << "'" << endl; //Error message if image name is invalid or does not exist
            return -1; //Function is exited 
        }
        else
		{
            imgs.push_back(img); //Images are stacked together 
		}
    }
	return 0;
}
