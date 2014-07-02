//
//  FA_PhotoDetailsViewController.h
//  FlickrApp
//
//  Created by Benjamin Myers on 7/2/14.
//  Copyright (c) 2014 AppGuys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface FA_PhotoDetailsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

// UI Properties
@property (strong, nonatomic) IBOutlet UITableView *commentsTableView;

// Variable Properties
@property (strong, nonatomic) Photo *currentPhoto;

@end
