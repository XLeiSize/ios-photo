//
//  ShibaView.h
//  iosPhoto
//
//  Created by Adrien Vanderpotte on 21/03/2016.
//  Copyright © 2016 XING Lei. All rights reserved.
//

#import <UIKit/UIKit.h>
#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface ShibaView : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIImageView *imageOverlayView;
extern BOOL firstTime;
extern BOOL isFront;
@end
