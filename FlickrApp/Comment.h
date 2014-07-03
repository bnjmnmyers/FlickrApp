//
//  Comment.h
//  FlickrApp
//
//  Created by Benjamin Myers on 7/3/14.
//  Copyright (c) 2014 AppGuys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;

@interface Comment : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * commentID;
@property (nonatomic, retain) Photo *photo;

@end
