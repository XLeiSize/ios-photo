//
//  Shiba.h
//  iosPhoto
//
//  Created by Eleve on 22/03/2016.
//  Copyright © 2016 XING Lei. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Shiba : NSObject

@property(nonatomic,strong) NSString *imgURL;
@property(nonatomic,strong) NSNumber *likes;
@property(nonatomic,strong) NSNumber *dislikes;
@property(nonatomic,strong) NSString *caption;

-(id)initWithImgUrl:(NSString*)imgUrl likes:(NSNumber*)likes dislikes:(NSNumber*)dislikes description:(NSString*)description;

@end
