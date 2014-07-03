//
//  FA_DataHandler.m
//  FlickrApp
//
//  Created by Benjamin Myers on 7/1/14.
//  Copyright (c) 2014 AppGuys. All rights reserved.
//

// Model Import
#import "FA_DataHandler.h"
#import "CoreDataHandler.h"
#import "Reachability.h"

// Data Import
#import "Owner.h"
#import "Comment.h"

#define searchWebService @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=0caf893cd241506996dc45f26ec8f560&format=json&per_page=20&page=1"

// searchWebService Full Format: https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=0caf893cd241506996dc45f26ec8f560&format=json&per_page=10&page=1&text=basketball&nojsoncallback=1

#define commentsWebSerivce @"https://api.flickr.com/services/rest/?method=flickr.photos.comments.getList&api_key=0caf893cd241506996dc45f26ec8f560&format=json"

// commentsWebService Full Format: https://api.flickr.com/services/rest/?method=flickr.photos.comments.getList&api_key=0caf893cd241506996dc45f26ec8f560&format=json&photo_id=2214598293


#define photoInfoWebService @"https://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=0caf893cd241506996dc45f26ec8f560&format=json"

// photoInfoWebService Full Format: https://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=0caf893cd241506996dc45f26ec8f560&format=json&user_id=100253755@N03&nojsoncallback=1

// To build image url: https:\/\/farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg

@implementation FA_DataHandler
{
	CoreDataHandler *coreDataHandler;
	Reachability *internetReachable;
}
-(void)searchPublicFlickrPhotosByKeyword:(NSString *)keyword
{
    id delegate = [[UIApplication sharedApplication]delegate];
	self.managedObjectContext = [delegate managedObjectContext];
	
	coreDataHandler = [[CoreDataHandler alloc] init];
	
    // Construct url string for search
	NSString *urlString = [NSString stringWithFormat:@"%@&text=%@&nojsoncallback=1", searchWebService, keyword];
    NSString *formattedURLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // Create url via formatted string
    NSURL *url = [NSURL URLWithString:formattedURLString];
    
    // Get all data from the return of the url
	NSData *photoData = [NSData dataWithContentsOfURL:url];
    
    // Place all data into a dictionary
    NSDictionary *allData = [NSJSONSerialization JSONObjectWithData:photoData options:kNilOptions error:nil];
    
    if ([allData count] > 0) {
        
        // Clear out entites to avoid duplicate records
        [coreDataHandler clearEntity:@"Photo" withFetchRequest:_fetchRequest];
        [coreDataHandler clearEntity:@"Owner" withFetchRequest:_fetchRequest];
        [coreDataHandler clearEntity:@"Comment" withFetchRequest:_fetchRequest];
        
        // Place photos data into a dictionary
        NSDictionary *photos = [allData objectForKey:@"photos"];
        
        // Place each photo object into a dictionary
        NSDictionary *photo = [photos objectForKey:@"photo"];
        
        // Loop through each photo object and place into Core Data
        for (NSDictionary *object in photo) {
            Photo *photoObj = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:[self managedObjectContext]];
            photoObj.farm = [object objectForKey:@"farm"];
            photoObj.title = [object objectForKey:@"title"];
            photoObj.server = [NSNumber numberWithInt:[NSLocalizedString([object objectForKey:@"server"], nil) intValue]];
            photoObj.secret = [object objectForKey:@"secret"];
            photoObj.ownerID = [object objectForKey:@"owner"];
            photoObj.isPublic = [NSNumber numberWithBool:[NSLocalizedString([object objectForKey:@"ispublic"], nil) boolValue]];
            photoObj.isFriend = [NSNumber numberWithBool:[NSLocalizedString([object objectForKey:@"isfriend"], nil) boolValue]];
            photoObj.isFamily = [NSNumber numberWithBool:[NSLocalizedString([object objectForKey:@"isfamily"], nil) boolValue]];
            photoObj.photoID = [object objectForKey:@"id"];
            
            
            // Get & Save photo owner info
            NSString *ownerInfoURLString = [NSString stringWithFormat:@"%@&photo_id=%@&user_id=%@&nojsoncallback=1", photoInfoWebService, photoObj.photoID, photoObj.ownerID];
            
            // Create url via formatted string
            NSURL *userURL = [NSURL URLWithString:ownerInfoURLString];
            
            // Get all data from the return of the url
            NSData *userData = [NSData dataWithContentsOfURL:userURL];
            
            // Place all data into a dictionary
            NSDictionary *allPhotoData = [NSJSONSerialization JSONObjectWithData:userData options:kNilOptions error:nil];
            
            // Get data wrapped in photo
            NSDictionary *photo = [allPhotoData objectForKey:@"photo"];
            
            // Get data wrapped in owner
            NSDictionary *owner = [photo objectForKey:@"owner"];
            
            Owner *newOwner = [NSEntityDescription insertNewObjectForEntityForName:@"Owner" inManagedObjectContext:[self managedObjectContext]];
            newOwner.username = [owner objectForKey:@"username"];
            newOwner.realname = [owner objectForKey:@"realname"];
            [newOwner setValue:photoObj forKey:@"photo"];
            [photoObj setValue:newOwner forKey:@"owner"];
            
            // Get & Save photo comments
            // Get & Save photo owner info
            NSString *commentsURLString = [NSString stringWithFormat:@"%@&photo_id=%@&nojsoncallback=1", commentsWebSerivce, photoObj.photoID];
            
            // Create url via formatted string
            NSURL *commentsURL = [NSURL URLWithString:commentsURLString];
            
            // Get all data from the return of the url
            NSData *commentsData = [NSData dataWithContentsOfURL:commentsURL];
            
            // Place all data into a dictionary
            NSDictionary *allCommentsData = [NSJSONSerialization JSONObjectWithData:commentsData options:kNilOptions error:nil];
            
            // Get data wrapped in comments
            NSDictionary *comments = [allCommentsData objectForKey:@"comments"];
            
            // Get data wrapped in comment
            NSDictionary *comment = [comments objectForKey:@"comment"];
            
            // Loop through and save each comments
            if ([comment count] != 0) {
                for (NSDictionary *object in comment) {
                    Comment *newComment = [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:[self managedObjectContext]];
                    newComment.content = [object objectForKey:@"_content"];
                    newComment.commentID = [object objectForKey:@"id"];
                    [photoObj addCommentObject:newComment];
                }
            }
        }
        [self.managedObjectContext save:nil];
    } else {
        _alert = [[UIAlertView alloc]initWithTitle:@"No Photos" message:@"No photos were returned for this search. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[_alert show];
    }
}

- (NSFetchedResultsController *)loadPhotoData
{
    id delegate = [[UIApplication sharedApplication]delegate];
	self.managedObjectContext = [delegate managedObjectContext];
    
    if (_fetchedPhotosController != nil)
	{
		return _fetchedPhotosController;
	}
    
    _fetchRequest = [[NSFetchRequest alloc] init];
    _entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:[self managedObjectContext]];
    _sort = [NSSortDescriptor sortDescriptorWithKey:@"photoID" ascending:YES];
    _sortDescriptors = [[NSArray alloc] initWithObjects:_sort, nil];
    
    [_fetchRequest setEntity:_entity];
    [_fetchRequest setSortDescriptors:_sortDescriptors];
    
    _fetchedPhotosController = [[NSFetchedResultsController alloc] initWithFetchRequest:_fetchRequest managedObjectContext:[self managedObjectContext] sectionNameKeyPath:@"photoID" cacheName:nil];
    
    return _fetchedPhotosController;
}


- (NSArray *)loadUserInfoByUserID:(NSString *)userID
{
    id delegate = [[UIApplication sharedApplication]delegate];
	self.managedObjectContext = [delegate managedObjectContext];
    
    _fetchRequest = [[NSFetchRequest alloc] init];
    _entity = [NSEntityDescription entityForName:@"Owner" inManagedObjectContext:[self managedObjectContext]];
    
    [_fetchRequest setEntity:_entity];
    
    NSError *error;
    _userInfo = [[self managedObjectContext] executeFetchRequest:_fetchRequest error:&error];
    
    return _userInfo;
}

- (NSArray *)loadCommentsByPhoto:(Photo *)photo
{
	Photo *selectedPhoto = photo;
	
	NSSet *comments = selectedPhoto.comment;
	NSSortDescriptor *commentsSort = [NSSortDescriptor sortDescriptorWithKey:@"commentID" ascending:YES];
	
	_sortedComments = [comments sortedArrayUsingDescriptors:[NSArray arrayWithObject:commentsSort]];
	
	return _sortedComments;
}


- (void)deleteExpiredPhotos
{
    NSDate *interval = [[NSDate date] dateByAddingTimeInterval:-60*60*24*30];
    NSDictionary *subs = [NSDictionary dictionaryWithObjectsAndKeys:interval, @"DATE", nil];
    NSFetchRequest *request = [[self managedObjectModel] fetchRequestFromTemplateWithName:@"Photo" substitutionVariables:subs];
    
    NSError *error = nil;
    NSArray *results = [[self managedObjectContext] executeFetchRequest:request error:&error];
    for(NSManagedObject *object in results) {
        [[self managedObjectContext] deleteObject:object];
    }
}

@end
