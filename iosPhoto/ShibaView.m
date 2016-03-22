//
//  ShibaView.m
//  iosPhoto
//
//  Created by Adrien Vanderpotte on 21/03/2016.
//  Copyright © 2016 XING Lei. All rights reserved.
//

#import "ShibaView.h"
#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
BOOL firstTime;
BOOL isFront;
@interface ShibaView ()
@property (strong, nonatomic) UIImagePickerController *picker;
@end

@implementation ShibaView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    firstTime = true;
    isFront = false;
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        [myAlertView show];
    }
    
}
- (void)viewDidAppear:(BOOL)animated {
    if(firstTime) {
        [self addCameraView];
    } else {
        [self addValidateView];

    }
}

-(void)addCameraView {
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.delegate = self;
    self.picker.allowsEditing = YES;
    self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    self.picker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    self.picker.showsCameraControls = NO;
    self.picker.navigationBarHidden = YES;
    self.picker.toolbarHidden = YES;
    
    CGAffineTransform translate = CGAffineTransformMakeTranslation(0.0, 71.0);
    self.picker.cameraViewTransform = translate;
    
    CGAffineTransform scale = CGAffineTransformScale(translate, 1.333333, 1.333333);
    self.picker.cameraViewTransform = scale;
    
    // Create overlay
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"shiba-overlay"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIView* overlayView = [[UIView alloc] initWithFrame:self.picker.view.frame];
    overlayView.backgroundColor = [UIColor colorWithPatternImage:image];
    
    // Add camera button
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cameraButton addTarget:self
                     action:@selector(snap)
           forControlEvents:UIControlEventTouchUpInside];
    cameraButton.frame = CGRectMake(0.0, 0.0, 80.0, 80.0);
    cameraButton.center = CGPointMake(self.imageView.center.x, self.imageView.frame.size.height - 80);
    cameraButton.layer.cornerRadius = 40;
    cameraButton.layer.borderWidth = 2;
    cameraButton.layer.borderColor = [UIColor colorWithRed:226.0/255.0 green:122.0/255.0 blue:63.0/255.0 alpha:1].CGColor;
    cameraButton.clipsToBounds = YES;
    cameraButton.backgroundColor = [UIColor whiteColor];
    
    UIImageView *cameraIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"camera.png"]];
    cameraIcon.frame = CGRectMake(15, 15, 50, 50);
    cameraIcon.contentMode=UIViewContentModeScaleAspectFill;
    [cameraButton addSubview:cameraIcon];
    
    [overlayView addSubview:cameraButton];
    
    // Add flip button
    UIButton *flipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [flipButton addTarget:self
                   action:@selector(flip)
         forControlEvents:UIControlEventTouchUpInside];
    flipButton.frame = CGRectMake(self.imageView.frame.size.width - 80.0, 20.0, 60.0, 60.0);
    flipButton.layer.cornerRadius = 30;
    flipButton.layer.borderWidth = 2;
    flipButton.layer.borderColor = [UIColor colorWithRed:226.0/255.0 green:122.0/255.0 blue:63.0/255.0 alpha:1].CGColor;
    flipButton.clipsToBounds = YES;
    flipButton.backgroundColor = [UIColor whiteColor];
    
    UIImageView *flipIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flip.png"]];
    flipIcon.frame = CGRectMake(15, 15, 30, 30);
    flipIcon.contentMode=UIViewContentModeScaleAspectFill;
    [flipButton addSubview:flipIcon];
    
    [overlayView addSubview:flipButton];
    
    // Add back button
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self
                   action:@selector(backHome)
         forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(20.0, 20.0, 60.0, 60.0);
    backButton.layer.cornerRadius = 30;
    backButton.layer.borderWidth = 2;
    backButton.layer.borderColor = [UIColor colorWithRed:226.0/255.0 green:122.0/255.0 blue:63.0/255.0 alpha:1].CGColor;
    backButton.clipsToBounds = YES;
    backButton.backgroundColor = [UIColor whiteColor];
    
    UIImageView *backIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back.png"]];
    backIcon.frame = CGRectMake(15, 15, 30, 30);
    backIcon.contentMode=UIViewContentModeScaleAspectFill;
    [backButton addSubview:backIcon];
    
    [overlayView addSubview:backButton];
    
    
    
    self.picker.cameraOverlayView = overlayView;
    
    [self presentViewController:self.picker animated:YES completion:NULL];
}

-(void)addValidateView {
    // Add back button
    UIButton *backButtonOverlay = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButtonOverlay addTarget:self
                          action:@selector(back)
                forControlEvents:UIControlEventTouchUpInside];
    backButtonOverlay.frame = CGRectMake(20.0, 20.0, 60.0, 60.0);
    backButtonOverlay.layer.cornerRadius = 30;
    backButtonOverlay.layer.borderWidth = 2;
    backButtonOverlay.layer.borderColor = [UIColor colorWithRed:226.0/255.0 green:122.0/255.0 blue:63.0/255.0 alpha:1].CGColor;
    backButtonOverlay.clipsToBounds = YES;
    backButtonOverlay.backgroundColor = [UIColor whiteColor];
    
    UIImageView *backIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back.png"]];
    backIcon.frame = CGRectMake(15, 15, 30, 30);
    backIcon.contentMode=UIViewContentModeScaleAspectFill;
    [backButtonOverlay addSubview:backIcon];
    
    [self.imageOverlayView addSubview:backButtonOverlay];
    
    // Add validate button
    UIButton *validateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [validateButton addTarget:self
                       action:@selector(validate)
             forControlEvents:UIControlEventTouchUpInside];
    validateButton.frame = CGRectMake(0.0, 0.0, 80.0, 80.0);
    validateButton.center = CGPointMake(self.imageView.center.x, self.imageView.frame.size.height - 80);
    validateButton.layer.cornerRadius = 40;
    validateButton.layer.borderWidth = 2;
    validateButton.layer.borderColor = [UIColor colorWithRed:226.0/255.0 green:122.0/255.0 blue:63.0/255.0 alpha:1].CGColor;
    validateButton.clipsToBounds = YES;
    validateButton.backgroundColor = [UIColor whiteColor];
    
    UIImageView *cameraIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"validate.png"]];
    cameraIcon.frame = CGRectMake(15, 15, 50, 50);
    cameraIcon.contentMode=UIViewContentModeScaleAspectFill;
    [validateButton addSubview:cameraIcon];
    
    [self.imageOverlayView addSubview:validateButton];
}

- (void)snap {
    NSLog(@"Snap");
    firstTime = false;
    [self.picker takePicture];
}

- (void)flip {
    NSLog(@"Flip");
    if(self.picker.cameraDevice == UIImagePickerControllerCameraDeviceFront)
    {
        isFront = false;
        self.picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    }
    else {
        isFront = true;
        self.picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        CGAffineTransform translate = CGAffineTransformMakeTranslation(0.0, 71.0);
        self.picker.cameraViewTransform = translate;
        self.picker.cameraViewTransform = CGAffineTransformScale(translate, 1.333333, 1.333333);
    }
}

- (void)backHome {
    firstTime = false;
    NSLog(@"back home");
    
    [self.picker dismissViewControllerAnimated:NO completion:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
    
    
}

- (void)back {
    firstTime = true;
    [self addCameraView];
}

- (void)validate {
    NSLog(@"validate");
    UIImage *image1 = self.imageView.image;
    UIImage *image2 = self.imageOverlayView.image;
    
    CGSize size = CGSizeMake(self.imageView.frame.size.width, self.imageView.frame.size.height);
    
    UIGraphicsBeginImageContext(size);
    
    [image1 drawInRect:CGRectMake(0,0,self.imageView.frame.size.width, self.imageView.frame.size.height)];
    [image2 drawInRect:CGRectMake(0,0,self.imageView.frame.size.width, self.imageView.frame.size.height)];
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(finalImage, nil, nil, nil);

    NSString *imageString = [self encodeToBase64String:finalImage];
    [self sendData:imageString];
}

- (void)sendData:(NSString *)imageString {
    Firebase *ref = [[Firebase alloc] initWithUrl:@"https://torrid-torch-679.firebaseio.com/ios/shibagram/shibas"];
    NSString *uuid = [NSUUID UUID].UUIDString;
    NSDictionary *shiba = @{
                            @"dislikes": @"0",
                            @"likes": @"0",
                            @"imgURL":imageString
    };
    Firebase *shibasRef = [ref childByAppendingPath: uuid];

    [shibasRef setValue: shiba];
}

- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    if (isFront) {
        self.imageView.image = [UIImage imageWithCGImage:chosenImage.CGImage scale:1.0 orientation: UIImageOrientationLeftMirrored];
    } else {
        self.imageView.image = chosenImage;
    }
        
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"shiba-overlay"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.imageOverlayView.image = image;
    self.imageOverlayView.userInteractionEnabled = true;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
@end
