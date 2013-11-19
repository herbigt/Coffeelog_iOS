//
//  FavoriteCell.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 19.11.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "FavoriteCell.h"

@interface FavoriteCell()

@property (strong, nonatomic) UILabel *favLabel;
@property (strong, nonatomic) UISwitch *favSwitch;

@end

@implementation FavoriteCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.favLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 250, self.bounds.size.height)];
        self.favLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        self.favLabel.textColor = UIColorFromRGB(0x61605e);
        self.favLabel.text = NSLocalizedString(@"Favorite", nil);
        
        CGFloat switchY = self.bounds.size.height/2 - 31/2;
        self.favSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(255, switchY, 52, 31)];
        self.favSwitch.tintColor = UIColorFromRGB(0xff9500);
        self.favSwitch.onTintColor = UIColorFromRGB(0xff9500);
        [self.favSwitch addTarget:self action:@selector(favoriteSwitchToggled:) forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:self.favLabel];
        [self addSubview:self.favSwitch];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

- (void)setCoffeeModel:(CoffeeModel *)coffeeModel {
    _coffeeModel = coffeeModel;
    
    self.favSwitch.on = self.coffeeModel.isFavorited;
}

- (void)favoriteSwitchToggled:(id)sender {
    self.coffeeModel.isFavorited = self.favSwitch.on;
}

@end
