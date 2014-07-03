//
//  FA_DataHandler.h
//  FlickrApp
//
//  Created by Benjamin Myers on 7/1/14.
//  Copyright (c) 2014 AppGuys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface FA_DataHandler : NSObject <UIAlertViewDelegate>

// Core Data Properties
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchRequest *fetchRequest;
@property (strong, nonatomic) NSEntityDescription *entity;
@property (nonatomic, strong) NSSortDescriptor *sort;
@property (nonatomic, strong) NSArray *sortDescriptors;
@property (nonatomic, strong) NSFetchedResultsController *fetchedPhotosController;

// Variable Properties
@property (strong, nonatomic) NSArray *photos;
@property (strong, nonatomic) NSArray *sortedComments;
@property (strong, nonatomic) NSArray *userInfo;
@property (strong, nonatomic) UIAlertView *alert;

- (void)searchPublicFlickrPhotosByKeyword:(NSString *)keyword;
- (NSFetchedResultsController *)loadPhotoData;
- (NSArray *)loadUserInfoByUserID:(NSString *)userID;
- (NSArray *)loadCommentsByPhoto:(Photo *)photo;

@end
