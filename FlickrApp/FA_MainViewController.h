//
//  FA_MainViewController.h
//  FlickrApp
//
//  Created by Benjamin Myers on 7/1/14.
//  Copyright (c) 2014 AppGuys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FA_MainViewController : UIViewController <UIAlertViewDelegate>

// UI Properties
@property (strong, nonatomic) IBOutlet UITextField *tfKeyword;
@property (strong, nonatomic) IBOutlet UIView *searchingView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UIAlertView *alert;

// Actions
- (IBAction)searchPhotos:(id)sender;

@end
