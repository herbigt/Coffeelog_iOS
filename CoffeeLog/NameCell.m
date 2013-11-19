//
//  NameCell.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 19.11.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "NameCell.h"

@implementation NameCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setCoffeeModel:(CoffeeModel *)coffeeModel {
    _coffeeModel = coffeeModel;
    
    UITextField *nameField = [[UITextField alloc] init];
    nameField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    nameField.textColor = UIColorFromRGB(0x8e8e93);
    nameField.placeholder = NSLocalizedString(@"Name", nil);
    nameField.returnKeyType = UIReturnKeyDone;
    
    nameField.frame = CGRectMake(16, 0, 294, self.bounds.size.height);
    
    [self addSubview:nameField];
}

@end
