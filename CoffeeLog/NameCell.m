//
//  NameCell.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 19.11.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "NameCell.h"

@interface NameCell()
@property (strong, nonatomic) UITextField *nameField;


@end

@implementation NameCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameField = [[UITextField alloc] init];
        self.nameField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        self.nameField.textColor = UIColorFromRGB(0x8e8e93);
        self.nameField.placeholder = NSLocalizedString(@"Name", nil);
        self.nameField.returnKeyType = UIReturnKeyDone;
        self.nameField.delegate = self;
        
        self.nameField.frame = CGRectMake(16, 0, 294, self.bounds.size.height);
        
        [self addSubview:self.nameField];

    }
    return self;
}

- (void)setCoffeeModel:(CoffeeModel *)coffeeModel {
    _coffeeModel = coffeeModel;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"didend");
    
    
    self.coffeeModel.name = textField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
