//
//  LocationCell.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 19.11.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "LocationCell.h"

@interface LocationCell()

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UITextField *websiteField;

@end

@implementation LocationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 250, self.bounds.size.height)];
        self.label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        self.label.textColor = UIColorFromRGB(0x8e8e93);
        self.label.text = NSLocalizedString(@"Location", nil);
        [self addSubview:self.label];
        
        self.websiteField = [[UITextField alloc] init];
        self.websiteField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        self.websiteField.textColor = UIColorFromRGB(0x8e8e93);
        self.websiteField.placeholder = NSLocalizedString(@"Website", nil);
        self.websiteField.returnKeyType = UIReturnKeyDone;
        self.websiteField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.websiteField.delegate = self;
        
        self.websiteField.frame = CGRectMake(16, 0, 294, self.bounds.size.height);
        [self addSubview:self.websiteField];


    }
    return self;
}

- (void)setCoffeeModel:(CoffeeModel *)coffeeModel {
    _coffeeModel = coffeeModel;
    
    if(self.isWebsite) {
        [self.label setHidden:YES];
        [self.websiteField setHidden:NO];
        
        self.accessoryType = UITableViewCellAccessoryNone;
    } else {
        [self.label setHidden:NO];
        [self.websiteField setHidden:YES];
        
        if(![self.coffeeModel.store isEqualToString:@""]) {
            self.label.text = self.coffeeModel.store;
        } else {
            self.label.text = NSLocalizedString(@"Location", nil);
        }
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.coffeeModel.store = textField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
