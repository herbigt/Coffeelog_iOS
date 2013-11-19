//
//  ChooseCell.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 19.11.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "ChooseCell.h"

@interface ChooseCell()

@property (strong, nonatomic) UILabel *typeLabel;

@end

@implementation ChooseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 250, self.bounds.size.height)];
        self.typeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        self.typeLabel.textColor = UIColorFromRGB(0x61605e);
        [self addSubview:self.typeLabel];
        
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}

- (void)setCoffeeModel:(CoffeeModel *)coffeeModel {
    _coffeeModel = coffeeModel;
    
    self.typeLabel.text = self.choiceLabel;
    
    NSInteger modelChoice = (NSInteger)[self.coffeeModel valueForKey:self.choiceProperty];
    
    if(modelChoice == self.currentIndex) {
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
}

@end
