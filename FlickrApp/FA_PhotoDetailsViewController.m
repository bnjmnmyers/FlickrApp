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

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

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
    
    // Get all comments for selected photo
    NSLog(@"%@", _currentPhoto.title);
    _sortedComments = [dataHandler loadCommentsByPhoto:_currentPhoto];
    
    _lblUsername.text = _currentPhoto.owner.username;
    _lblRealname.text = _currentPhoto.owner.realname;
    _lblCommentCount.text = [NSString stringWithFormat:@"%d",[_sortedComments count]];

    // Get image to display in a larger format
    NSString *getStringURL = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", _currentPhoto.farm, _currentPhoto.server, _currentPhoto.photoID, _currentPhoto.secret];
    NSURL *getImgURL = [NSURL URLWithString:getStringURL];
    NSData *getImageData = [NSData dataWithContentsOfURL:getImgURL];
    UIImage *chosenImage = [UIImage imageWithData:getImageData];
    _imageView.image = chosenImage;
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [_sortedComments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if ( cell == nil ) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	_comment = [_sortedComments objectAtIndex:indexPath.row];
    // Configure the cell...
    
    cell.textLabel.text = _comment.content;
    cell.textLabel.numberOfLines = 0;
   
   
    
    return cell;
}



@end
