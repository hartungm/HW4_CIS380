//
//  MasterViewController.m
//  TopArtists
//
//  Created by Michael Hartung and Matt Armand on 10/20/14.
//  Copyright (c) 2014 hartung-michael. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "HttpCommunication.h"
#import "ArtistTableViewCell.h"
#import "UIImageView+Network.h"

@interface MasterViewController ()

@property (nonatomic, strong) NSArray *objects;
@property (nonatomic, strong) HttpCommunication *http;
@end

@implementation MasterViewController

- (void)awakeFromNib {
	[super awakeFromNib];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.http = [[HttpCommunication alloc] init];
	NSURL *earl = [NSURL URLWithString: @"http://ws.audioscrobbler.com/2.0/?method=geo.gettopartists&country=italy&api_key=194591ada49dac51b2973b8a43ba71a3&format=json"];
	[self.http retrieveURL:earl withSuccessBlock:^(NSData *response) {
		NSError *error = nil;
		NSDictionary *topLevel = [NSJSONSerialization JSONObjectWithData:response options:0 error:&error];
		
		if(!error)
		{
			NSDictionary *topArtists = topLevel[@"topartists"];
			self.objects = topArtists[@"artist"];
			[self.tableView reloadData];
		}
	}];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}



#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([[segue identifier] isEqualToString:@"toArtist"]) {
	    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
	    NSDictionary *object = self.objects[indexPath.row];
		[[segue destinationViewController] setDetailItem:object];
	}
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	ArtistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"artistCell" forIndexPath:indexPath];

	NSDictionary *artist = self.objects[indexPath.row];
	cell.artistLabel.text = artist[@"name"];
	cell.artistListeners.text = [@"Listeners: " stringByAppendingString:artist[@"listeners"]];
	NSDictionary *image = artist[@"image"][2];
	NSString *imageURL = image[@"#text"];
	if(imageURL != nil)
	{
		[cell.artistImage loadImageFromURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"Last_fm_logo.png"] cachingKey:imageURL];
	}
	else
	{
		cell.artistImage.image = [UIImage imageNamed:@"Last_fm_logo.png"];
	}
	return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	// Return NO if you do not want the specified item to be editable.
	return NO;
}

@end
