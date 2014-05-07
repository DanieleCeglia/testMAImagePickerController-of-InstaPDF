//
//  ViewController.m
//  testMAImagePickerController-of-InstaPDF
//
//  Created by Daniele Ceglia on 06/05/14.
//  Copyright (c) 2014 Relifeit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    BOOL testOpenCvInEsecuzione;
}
@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:_immagine];
    /*
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPresetPhoto;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultFPS = 30;
    self.videoCamera.grayscaleMode = NO;
    */
    self.videoCamera.delegate = self;
    
    testOpenCvInEsecuzione = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Metodi miei

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - CvVideoCameraDelegate

#ifdef __cplusplus
- (void)processImage:(cv::Mat&)image;
{
    // Do some OpenCV stuff with the image
    cv::Mat image_copy;
    cvtColor(image, image_copy, CV_BGRA2BGR);
    
    // invert image
    bitwise_not(image_copy, image_copy);
    cvtColor(image_copy, image, CV_BGR2BGRA);
}
#endif

#pragma mark - Metodi d'azione

- (IBAction)testOpenCV:(id)sender
{
    NSLog(@"testOpenCV...");
    
    if (testOpenCvInEsecuzione == NO)
    {
        [self.videoCamera start];
        
        testOpenCvInEsecuzione = YES;
    }
    else
    {
        [self.videoCamera stop];
        
        testOpenCvInEsecuzione = NO;
    }
}

- (IBAction)apriCrop:(id)sender
{
    NSLog(@"apriCrop...");
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Elabora foto da"
                                                       delegate:self
                                              cancelButtonTitle:@"Annulla"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Scatta nuova", @"Prendi da libreria", nil];
    
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    MAImagePickerController *imagePicker = [[MAImagePickerController alloc] init];
    
    imagePicker.delegate = self;
    
    if (buttonIndex == 1)
    {
        imagePicker.sourceType = MAImagePickerControllerSourceTypePhotoLibrary;
    }
    
    //imagePicker.sourceType = MAImagePickerControllerSourceTypeCamera;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePicker];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - MAImagePickerControllerDelegate

- (void)imagePickerDidCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerDidChooseImageWithPath:(NSString *)path
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSLog(@"File Found at %@", path);
        
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
        
        self.immagine.image = [UIImage imageWithData:data];
    }
    else
    {
        NSLog(@"No File Found at %@", path);
    }
    
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

@end
