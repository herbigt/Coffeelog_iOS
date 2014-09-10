//
//  NoteCellCell.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 03/09/14.
//  Copyright (c) 2014 CoffeeLog. All rights reserved.
//

#import "NoteCell.h"
#import "AUIAutoGrowingTextView.h"


@interface NoteCell()
@property (strong, nonatomic) UITextView *noteField;


@end

@implementation NoteCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.noteField = [[UITextView alloc] init];
        self.noteField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.noteField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        self.noteField.textColor = UIColorFromRGB(0x8e8e93);
        self.noteField.returnKeyType = UIReturnKeyDone;
        self.noteField.delegate = self;
        [self.noteField sizeToFit];
        
        self.noteField.frame = CGRectMake(16, 0, 294, self.noteField.bounds.size.height);
        
        [self addSubview:self.noteField];
    }
    return self;
}

- (void)setCoffeeModel:(CoffeeModel *)coffeeModel {
    _coffeeModel = coffeeModel;
    
    if(![self.coffeeModel.notes isEqualToString:@""]) {
        self.noteField.text = self.coffeeModel.notes;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.coffeeModel.notes = textView.text;
}

@end
