//
//  FA_PhotoDetailsViewController.m
//  FlickrApp
//
//  Created by Benjamin Myers on 7/2/14.
//  Copyright (c) 2014 AppGuys. All rights reserved.
//

// Controllers Import
#import "FA_PhotoDetailsViewController.h"

// Models Import
#import "FA_DataHandler.h"

// Data Import
#import "Owner.h"

@interface FA_PhotoDetailsViewController ()
{
    FA_DataHandler *dataHandler;
}

@end

@implementation FA_PhotoDetailsViewController

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
    
    dataHandler = [[FA_DataHandler alloc] init];
    NSLog(@"OWNER USERNAME:%@", _currentPhoto.owner.username);
    NSLog(@"OWNER REALNAME:%@", _currentPhoto.owner.realname);
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
   
    return cell;
}

@end
