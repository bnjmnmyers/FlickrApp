//
//  Photo.h
//  FlickrApp
//
//  Created by Benjamin Myers on 7/2/14.
//  Copyright (c) 2014 AppGuys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, Owner;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSNumber * farm;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * server;
@property (nonatomic, retain) NSNumber * secret;
@property (nonatomic, retain) NSString * ownerID;
@property (nonatomic, retain) NSNumber * isPublic;
@property (nonatomic, retain) NSNumber * isFriend;
@property (nonatomic, retain) NSNumber * isFamily;
@property (nonatomic, retain) NSString * photoID;
@property (nonatomic, retain) NSSet *comment;
@property (nonatomic, retain) Owner *owner;
@end

@interface Photo (CoreDataGeneratedAccessors)

- (void)addCommentObject:(Comment *)value;
- (void)removeCommentObject:(Comment *)value;
- (void)addComment:(NSSet *)values;
- (void)removeComment:(NSSet *)values;

@end
