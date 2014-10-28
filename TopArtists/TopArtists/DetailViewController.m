//
//  DetailViewController.m
//  TopArtists
//
//  Created by Michael Hartung on 10/20/14.
//  Copyright (c) 2014 hartung-michael. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIActivityIndicatorView *webCounter;
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
		NSString *mobileString = [earlString stringByReplacingOccurrencesOfString:@"www.last.fm" withString:@"m.last.fm"];
		NSURL *earl = [NSURL URLWithString:mobileString];
		NSURLRequest *request = [NSURLRequest requestWithURL:earl];
		self.webView.delegate = self;
		[self.webView loadRequest:request];
	}
}

-(UIActivityIndicatorView *) webActivityIndicator
{
	if(!self.webCounter)
	{
		self.webCounter = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		self.webCounter.hidesWhenStopped = YES;
	}
	return self.webCounter;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	UIBarButtonItem *activity = [[UIBarButtonItem alloc] initWithCustomView:self.webCounter];
	UIBarButtonItem *safari = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(viewInSafari)];
	self.navigationItem.rightBarButtonItems = @[safari, activity];
	[self configureView];
}

-(void) updateBackButton
{
	if([self.webView canGoBack])
	{
		if(!self.navigationItem.leftBarButtonItem)
		{
			[self.navigationItem setHidesBackButton:YES animated:YES];
			UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backPressed)];
			[self.navigationItem setLeftBarButtonItem:backItem animated:YES];
		}
	}
	else
	{
		[self.navigationItem setLeftBarButtonItem:nil animated:YES];
		[self.navigationItem setHidesBackButton:NO animated:YES];
	}
}

-(void) backPressed
{
	if([self.webView canGoBack])
	{
		[self.webView goBack];
	}
}

-(void)viewInSafari
{
	NSURL *earl = [NSURL URLWithString: self.artistURL];
	if(![[UIApplication sharedApplication] openURL:earl]);
	{
		// TODO: Log a message.
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
	[self.webCounter startAnimating];
	[self updateBackButton];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
	[self.webCounter stopAnimating];
	[self updateBackButton];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	[self.webCounter stopAnimating];
}
@end
