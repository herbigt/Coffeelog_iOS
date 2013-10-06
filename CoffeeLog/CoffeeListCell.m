//
//  CoffeeListCell.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 06.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "CoffeeListCell.h"
@interface CoffeeListCell ()

@property (strong, nonatomic) UIImageView *coffeeImageView;
@property (strong, nonatomic) UIView *infoView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *typeLabel;
@property (strong, nonatomic) UIImageView *storeIcon;
@property (strong, nonatomic) UILabel *storeLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UIImageView *favoriteIcon;

@end

@implementation CoffeeListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.coffeeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 85, 85)];
        [self addSubview:self.coffeeImageView];
        
        self.infoView = [[UIView alloc] initWithFrame:CGRectMake(115, 15, 180, 85)];
        [self addSubview:self.infoView];
        
        self.favoriteIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"favorite"]];
        self.favoriteIcon.frame = CGRectMake(self.infoView.bounds.size.width - self.favoriteIcon.bounds.size.width, 0, self.favoriteIcon.bounds.size.width, self.favoriteIcon.bounds.size.height);
        [self.infoView addSubview:self.favoriteIcon];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 25)];
        self.nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17.0];
        self.nameLabel.textColor = UIColorFromRGB(0x61605e);
        [self.infoView addSubview:self.nameLabel];
        
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, MAX_Y(self.nameLabel) - 5, 160, 25)];
        self.typeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0];
        self.typeLabel.textColor = UIColorFromRGB(0x61605e);
        [self.infoView addSubview:self.typeLabel];
        
        self.storeIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location"]];
        self.storeIcon.frame = CGRectMake(0, MAX_Y(self.typeLabel) + 5, self.storeIcon.bounds.size.width, self.storeIcon.bounds.size.height);
        [self.infoView addSubview:self.storeIcon];
        
        self.storeLabel = [[UILabel alloc] initWithFrame:CGRectMake(MAX_X(self.storeIcon) + 5, MAX_Y(self.typeLabel), 160, 25)];
        self.storeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0];
        self.storeLabel.textColor = UIColorFromRGB(0x61605e);
        [self.infoView addSubview:self.storeLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, MAX_Y(self.storeLabel) - 5, 160, 25)];
        self.priceLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0];
        self.priceLabel.textColor = UIColorFromRGB(0x61605e);
        [self.infoView addSubview:self.priceLabel];
    }
    return self;
}

- (void)setCoffeeModel:(CoffeeModel*)model {
    _coffeeModel = model;
    
    [self.coffeeImageView setImage:model.image];
    [self.nameLabel setText:model.name];
    [self.typeLabel setText:model.type];
    [self.storeLabel setText:model.store];
    [self.priceLabel setText:[NSString stringWithFormat:@"%.2f€ / %.2fg", (model.price/100.0f), (model.weight/100.0f)]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
