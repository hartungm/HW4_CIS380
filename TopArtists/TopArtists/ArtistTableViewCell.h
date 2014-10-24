//
//  ArtistTableViewCell.h
//  TopArtists
//
//  Created by Michael Hartung on 10/22/14.
//  Copyright (c) 2014 hartung-michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArtistTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *artistImage;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistListeners;
@end
