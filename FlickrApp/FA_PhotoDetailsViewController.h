//
//  FA_PhotoDetailsViewController.h
//  FlickrApp
//
//  Created by Benjamin Myers on 7/2/14.
//  Copyright (c) 2014 AppGuys. All rights reserved.
//

#import <UIKit/UIKit.h>

// Data Import
#import "Comment.h"
#import "Photo.h"

@interface FA_PhotoDetailsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

// UI Properties
@property (strong, nonatomic) IBOutlet UITableView *commentsTableView;
@property (strong, nonatomic) IBOutlet UILabel *lblUsername;
@property (strong, nonatomic) IBOutlet UILabel *lblRealname;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *lblCommentCount;

// Variable Properties
@property (strong, nonatomic) Comment *comment;
@property (strong, nonatomic) Photo *currentPhoto;
@property (strong, nonatomic) NSArray *sortedComments;

@end
