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
        
        self.favSwitch = [[UISwitch alloc] init];
        
        self.favSwitch.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.favSwitch.tintColor = UIColorFromRGB(0xff9500);
        self.favSwitch.onTintColor = UIColorFromRGB(0xff9500);
        [self.favSwitch addTarget:self action:@selector(favoriteSwitchToggled:) forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:self.favLabel];
        [self addSubview:self.favSwitch];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.favSwitch attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.favSwitch attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        
        
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
