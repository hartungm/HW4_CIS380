//
//  DetailViewController.h
//  TopArtists
//
//  Created by Michael Hartung and Matt Armand on 10/20/14.
//  Copyright (c) 2014 hartung-michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) NSDictionary *detailItem;
@property (nonatomic) NSString *artistName;
@property (nonatomic) NSString *artistURL;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

