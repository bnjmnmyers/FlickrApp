//
//  FA_PhotosTableViewController.h
//  FlickrApp
//
//  Created by Benjamin Myers on 7/2/14.
//  Copyright (c) 2014 AppGuys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FA_PhotosTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

// Core Data Properties
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedPhotosController;

// Variable Properties
@property (strong, nonatomic) NSArray *photos;
@property (strong, nonatomic) NSIndexPath *indexPath;

@end
