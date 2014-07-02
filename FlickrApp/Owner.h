//
//  Owner.h
//  FlickrApp
//
//  Created by Benjamin Myers on 7/2/14.
//  Copyright (c) 2014 AppGuys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;

@interface Owner : NSManagedObject

@property (nonatomic, retain) NSString * realname;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) Photo *photo;

@end
