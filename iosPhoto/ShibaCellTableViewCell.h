//
//  ShibaCellTableViewCell.h
//  iosPhoto
//
//  Created by Eleve on 22/03/2016.
//  Copyright © 2016 XING Lei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShibaCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet UILabel *CaptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *LikesLabel;
@property (weak, nonatomic) IBOutlet UILabel *DislikesLabel;

@end
