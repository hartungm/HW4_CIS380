//
//  HttpCommunication.h
//  TopArtists
//
//  Created by Michael Hartung and Matt Armand on 10/20/14.
//  Copyright (c) 2014 hartung-michael. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpCommunication : NSObject <NSURLSessionDataDelegate>
- (void) retrieveURL:(NSURL*)url withSuccessBlock:(void (^) (NSData*))successBlock;
@end
