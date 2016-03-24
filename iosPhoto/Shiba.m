//
//  Shiba.m
//  iosPhoto
//
//  Created by Eleve on 22/03/2016.
//  Copyright © 2016 XING Lei. All rights reserved.
//

#import "Shiba.h"


@implementation Shiba

-(id)initWithUUID:(NSString*)uuid imgURL:(NSString*)imgUrl likes:(NSNumber*)likes dislikes:(NSNumber*)dislikes dateTime:(NSString*)dateTime {
    if(self = [super init]) {
        self.uuid = uuid;
        self.imgURL = imgUrl;
        self.likes = likes;
        self.dislikes = dislikes;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
        self.dateTime = [dateFormatter dateFromString:dateTime];
        
    }
    return self;
}

-(void)addLike{
}


@end
