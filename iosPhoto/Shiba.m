//
//  Shiba.m
//  iosPhoto
//
//  Created by Eleve on 22/03/2016.
//  Copyright © 2016 XING Lei. All rights reserved.
//

#import "Shiba.h"


@implementation Shiba

-(id)initWithUUID:(NSString*)uuid imgURL:(NSString*)imgUrl likes:(NSNumber*)likes dislikes:(NSNumber*)dislikes description:(NSString*)caption {
    if(self = [super init]) {
        self.uuid = uuid;
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

-(void)addLike{
    //     Get a reference to our posts
    Firebase *ref = [[Firebase alloc] initWithUrl: [NSString stringWithFormat:@"https://torrid-torch-679.firebaseio.com/ios/shibagram/shibas/%@",NULL ]];
    // Retrieve new posts as they are added to the database
    [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSInteger likes = [snapshot.value intValue];
        likes ++;
        NSLog(@"%ld", (long)likes);
        NSDictionary *newLikes = @{
                                   @"likes": [NSString stringWithFormat:@"%ld", (long)likes],
                                   };
        [ref updateChildValues: newLikes];
        
    }];
}


@end
