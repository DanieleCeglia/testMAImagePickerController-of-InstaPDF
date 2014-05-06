//
//  ViewController.h
//  testMAImagePickerController-of-InstaPDF
//
//  Created by Daniele Ceglia on 06/05/14.
//  Copyright (c) 2014 Relifeit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <opencv2/highgui/cap_ios.h>
//using namespace cv;

#import "MAImagePickerController.h"

@interface ViewController : UIViewController <CvVideoCameraDelegate, MAImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *immagine;
@property (nonatomic, strong) CvVideoCamera* videoCamera;

- (IBAction)testOpenCV:(id)sender;
- (IBAction)apriCrop:(id)sender;

@end
