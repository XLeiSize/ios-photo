//
//  ShibaView.h
//  iosPhoto
//
//  Created by Adrien Vanderpotte on 21/03/2016.
//  Copyright © 2016 XING Lei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>
@interface ShibaView : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIImageView *imageOverlayView;
extern BOOL firstTime;
extern BOOL isFront;
@end