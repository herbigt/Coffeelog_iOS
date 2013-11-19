//
//  FavoriteCell.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 19.11.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "FavoriteCell.h"

@implementation FavoriteCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setCoffeeModel:(CoffeeModel *)coffeeModel {
    _coffeeModel = coffeeModel;
    
    
    CGFloat cellHeight = self.bounds.size.height;
    
    UILabel *favLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 250, cellHeight)];
    favLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    favLabel.textColor = UIColorFromRGB(0x61605e);
    favLabel.text = NSLocalizedString(@"Favorite", nil);
    
    CGFloat switchY = cellHeight/2 - 31/2;
    UISwitch *favSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(255, switchY, 52, 31)];
    favSwitch.tintColor = UIColorFromRGB(0xff9500);
    favSwitch.onTintColor = UIColorFromRGB(0xff9500);
    //[favSwitch addTarget:self action:@selector(favoriteSwitchToggled:) forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:favLabel];
    [self addSubview:favSwitch];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
