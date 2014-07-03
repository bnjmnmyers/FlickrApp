//
//  FA_PhotosTableViewController.m
//  FlickrApp
//
//  Created by Benjamin Myers on 7/2/14.
//  Copyright (c) 2014 AppGuys. All rights reserved.
//

// Controllers Import
#import "FA_PhotosTableViewController.h"
#import "FA_PhotoDetailsViewController.h"

// Models Import
#import "FA_DataHandler.h"

// Data Import
#import "Photo.h"

@interface FA_PhotosTableViewController ()
{
    FA_DataHandler *dataHandler;
}
@end

@implementation FA_PhotosTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    id delegate = [[UIApplication sharedApplication]delegate];
	self.managedObjectContext = [delegate managedObjectContext];
    
    dataHandler = [[FA_DataHandler alloc] init];
    
    NSError *error;
	if (![[dataHandler loadPhotoData] performFetch:&error]) {
		NSLog(@"An error has occurred: %@", error);
		abort();
	}
	_fetchedPhotosController = dataHandler.fetchedPhotosController;
	_fetchedPhotosController.delegate = self;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[_fetchedPhotosController sections]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[_fetchedPhotosController sections] objectAtIndex:section]
            numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Photo *newPhoto = nil;
    newPhoto = [_fetchedPhotosController objectAtIndexPath:indexPath];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        
        NSString *getStringURL = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@_s.jpg", newPhoto.farm, newPhoto.server, newPhoto.photoID, newPhoto.secret];
        NSURL *getImgURL = [NSURL URLWithString:getStringURL];
        NSData *getImageData = [NSData dataWithContentsOfURL:getImgURL];
        UIImage *getImageToSync = [UIImage imageWithData:getImageData];
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            
            // Load actual image.
            [[cell imageView]setImage:getImageToSync];
            [cell setNeedsLayout];
            
            // Create a new label, hide it and fill it with the id for the given object.
            cell.textLabel.text = newPhoto.title;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"Comments: %d", [newPhoto.comment count]];
            cell.textLabel.numberOfLines = 0;
            
        });
        
    });
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segueToPhotoDetails"]) {
        _indexPath = [self.tableView indexPathForSelectedRow];
        FA_PhotoDetailsViewController *pdvc = [segue destinationViewController];
        pdvc.currentPhoto = [_fetchedPhotosController objectAtIndexPath:_indexPath];
    }
}


@end
