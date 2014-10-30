//
//  HttpCommunication.m
//  TopArtists
//
//  Created by Michael Hartung and Matt Armand on 10/20/14.
//  Copyright (c) 2014 hartung-michael. All rights reserved.
//

#import "HttpCommunication.h"
#import "AppDelegate.h"

@interface HttpCommunication()
@property (nonatomic, copy) void(^successBlock)(NSData *);
@end

@implementation HttpCommunication 

- (void) retrieveURL:(NSURL*)url withSuccessBlock:(void (^) (NSData*))successBlock
{
	self.successBlock = successBlock;
	[(AppDelegate*)[[UIApplication sharedApplication] delegate] incrementNetworkCounter];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
	NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
	
	NSURLSessionTask *task = [session downloadTaskWithRequest:request];
	[task resume];
}

- (void) URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
	NSData *data = [NSData dataWithContentsOfURL:location];
	dispatch_async(dispatch_get_main_queue(), ^{
		[(AppDelegate*)[[UIApplication sharedApplication] delegate] decrementNetworkCounter];
		self.successBlock(data);
	});
}

@end
