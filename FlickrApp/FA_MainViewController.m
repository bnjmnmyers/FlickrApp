//
//  FA_MainViewController.m
//  FlickrApp
//
//  Created by Benjamin Myers on 7/1/14.
//  Copyright (c) 2014 AppGuys. All rights reserved.
//

// Controllers Import
#import "FA_MainViewController.h"

// Models Import
#import "FA_DataHandler.h"
#import "Reachability.h"

@interface FA_MainViewController ()
{
    Reachability *internetReachable;
    FA_DataHandler *dataHandler;
}
@end

@implementation FA_MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Setup and test for connectivity
    internetReachable = [[Reachability alloc] init];
    dataHandler = [[FA_DataHandler alloc] init];
    [internetReachable checkConnection];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)searchPhotos:(id)sender
{
    if (internetReachable.isConnected) {
        NSLog(@"Yoooouuuuu... You've got what I need!");
        dispatch_async(dispatch_get_main_queue(), ^{
            [dataHandler searchPublicFlickrPhotosByKeyword:_tfKeyword.text];
        });
        [self performSegueWithIdentifier:@"segueToPhotos" sender:self];
    }
}
@end
