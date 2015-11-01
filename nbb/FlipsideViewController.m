//
//  FlipsideViewController.m
//  Bibocard1
//
//  Created by Timofey Solonin on 10/5/14.
//  Copyright (c) 2014 Timofey Solonin. All rights reserved.
//

#import "FlipsideViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <ZXingObjC/ZXingObjC.h>
#import "Gradient.h"

@interface FlipsideViewController ()
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UILabel *StudentId;

@end

@implementation FlipsideViewController
@synthesize str1, str2, str3, str4, label, barcode, photo;


- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    //	(iOS 5)
    //	Only allow rotation to portrait
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (BOOL)shouldAutorotate
{
    //	(iOS 6)
    //	No auto rotating
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    //	(iOS 6)
    //	Only allow rotation to portrait
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    //	(iOS 6)
    //	Force to portrait
    return UIInterfaceOrientationLandscapeLeft;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSMutableString *buffer = [[NSMutableString alloc] initWithString:@"ID #"];
    [buffer appendString:str3];
    _StudentId.text = buffer;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix *result = [writer encode:str3
                                  format:kBarcodeFormatCode39
                                   width:400
                                  height:50
                                   error:nil];
    
    CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
    UIImage *myIm = [[UIImage alloc] initWithCGImage: image];
    [barcode setImage: myIm];
    NSString *urlstring = @"https://skystorage.iscorp.com/pictures/il/meritas//";
    NSString *endstring = [[NSString alloc]init];
    NSString *endstring2 = [[NSString alloc]init];
    endstring = [urlstring stringByAppendingString: str3];
    endstring2 = [endstring stringByAppendingFormat: @".jpg"];
    NSURL *url = [NSURL URLWithString: endstring2];
    NSData *data = [NSData dataWithContentsOfURL : url];
    UIImage *image1 = [UIImage imageWithData: data];
    [photo setImage: image1];
    NSLog(@"%@",str4);
    label.text = str4;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) setupGradients {
    
    CAGradientLayer *gradientLayer = [Gradient greyGradient];
    gradientLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
    
    
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
