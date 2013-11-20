//
//  NumberCell.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 19.11.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "NumberCell.h"

@interface NumberCell()

@property (strong, nonatomic) UILabel *unitLabel;
@property (strong, nonatomic) UITextField *unitField;

@end

@implementation NumberCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 45, self.bounds.size.height)];
        self.unitLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        self.unitLabel.textColor = UIColorFromRGB(0x61605e);
        
        [self addSubview:self.unitLabel];
        
        self.unitField = [[UITextField alloc] init];
        self.unitField.frame = CGRectMake(16, 0, 60, self.bounds.size.height);
        self.unitField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        self.unitField.textColor = UIColorFromRGB(0x8e8e93);
        self.unitField.keyboardType = UIKeyboardTypeDecimalPad;
        self.unitField.returnKeyType = UIReturnKeyDone;
        self.unitField.delegate = self;
        
        [self addSubview:self.unitField];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}


- (void)setCoffeeModel:(CoffeeModel *)coffeeModel {
    _coffeeModel = coffeeModel;
    
    self.unitField.placeholder = self.numberPlaceholder;
    
    NSInteger unit = [[self.coffeeModel valueForKey:self.numberProperty] integerValue];
    if(unit != 0) {
        self.unitField.text = [NSString stringWithFormat:@"%f", unit/100.f];
    }
    
    self.unitLabel.text = self.numberUnit;
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.coffeeModel setValue:[NSNumber numberWithInteger:([textField.text floatValue] * 100)] forKey:self.numberProperty];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
