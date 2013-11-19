//
//  NumberCell.h
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 19.11.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CoffeeModel.h"

@interface NumberCell : UITableViewCell <UITextFieldDelegate>


@property (strong, nonatomic) CoffeeModel *coffeeModel;

@property (strong, nonatomic) NSString *numberUnit;
@property (strong, nonatomic) NSString *numberLabel;
@property (strong, nonatomic) NSString *numberProperty;

@end
