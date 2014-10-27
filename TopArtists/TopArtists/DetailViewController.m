//
//  DetailViewController.m
//  TopArtists
//
//  Created by Michael Hartung on 10/20/14.
//  Copyright (c) 2014 hartung-michael. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
	if (_detailItem != newDetailItem) {
		_detailItem = newDetailItem;
		
		// Update the view.
		[self configureView];
	}
}

- (void)configureView {
	// Update the user interface for the detail item.
	if(self.detailItem)
	{
		NSString *earlString = self.detailItem[@"url"];
		NSString *mobileString = [earlString stringByReplacingOccurrencesOfString:@"www" withString:@"m"];
		NSURL *earl = [NSURL URLWithString:mobileString];
		NSURLRequest *request = [NSURLRequest requestWithURL:earl];
		[self.webView loadRequest:request];
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self configureView];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
