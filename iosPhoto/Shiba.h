//
//  Shiba.h
//  iosPhoto
//
//  Created by Eleve on 22/03/2016.
//  Copyright © 2016 XING Lei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>


@interface Shiba : NSObject

@property(nonatomic,strong) NSString *uuid;
@property(nonatomic,strong) NSString *imgURL;
@property(nonatomic,strong) NSNumber *likes;
@property(nonatomic,strong) NSNumber *dislikes;
@property(nonatomic,strong) NSDate *dateTime;

-(id)initWithUUID:(NSString*)uuid imgURL:(NSString*)imgUrl likes:(NSNumber*)likes dislikes:(NSNumber*)dislikes dateTime:(NSString*)dateTime;

@end
