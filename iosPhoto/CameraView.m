//
//  CameraView.m
//  iosPhoto
//
//  Created by Adrien Vanderpotte on 21/03/2016.
//  Copyright © 2016 XING Lei. All rights reserved.
//

#import "CameraView.h"

@interface CameraView : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)takePhoto:(UIButton *)sender;

@end

@implementation CameraView

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"lol");
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)snapButton:(id)sender {
}
- (IBAction)takePhoto:(UIButton *)sender {
}
@end
