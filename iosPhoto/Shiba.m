//
//  Shiba.m
//  iosPhoto
//
//  Created by Eleve on 22/03/2016.
//  Copyright © 2016 XING Lei. All rights reserved.
//

#import "Shiba.h"


@implementation Shiba

-(id)initWithImgUrl:(NSString*)imgUrl likes:(NSNumber*)likes dislikes:(NSNumber*)dislikes description:(NSString*)caption {
    if(self = [super init]) {
        self.imgURL = imgUrl;
        self.likes = likes;
        self.dislikes = dislikes;
        self.caption = caption;
    }
    return self;
}

-(NSString*)imgURL{
    if(![_imgURL hasPrefix:@"http:"]){
        return [NSString stringWithFormat:@"http:%@", _imgURL];
    }
    return _imgURL;
}


@end
