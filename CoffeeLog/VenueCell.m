//
//  VenueCell.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 20.11.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "VenueCell.h"

@implementation VenueCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        self.textLabel.textColor = UIColorFromRGB(0x61605e);
        
        
        self.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
        self.detailTextLabel.textColor = UIColorFromRGB(0x61605e);
    }
    return self;
}

- (void)setVenue:(NSDictionary *)dictionary {
    self.textLabel.text = dictionary[@"name"];
    
    if(dictionary[@"location"] && dictionary[@"location"][@"address"]) {
        self.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@ %@", dictionary[@"location"][@"address"], dictionary[@"location"][@"postalCode"], dictionary[@"location"][@"city"]];       
    }
}

@end
