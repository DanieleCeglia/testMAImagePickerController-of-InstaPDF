//
//  ViewController.m
//  testMAImagePickerController-of-InstaPDF
//
//  Created by Daniele Ceglia on 06/05/14.
//  Copyright (c) 2014 Relifeit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Metodi d'azione

- (IBAction)apriCrop:(id)sender
{
    NSLog(@"bottone schiacciato...");
}

@end
