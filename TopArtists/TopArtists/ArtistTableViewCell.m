//
//  ArtistTableViewCell.m
//  TopArtists
//
//  Created by Michael Hartung on 10/22/14.
//  Copyright (c) 2014 hartung-michael. All rights reserved.
//

#import "ArtistTableViewCell.h"

@implementation ArtistTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
	}
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
