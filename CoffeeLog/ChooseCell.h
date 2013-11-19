//
//  ChooseCell.h
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 19.11.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CoffeeModel.h"

@interface ChooseCell : UITableViewCell

@property (strong, nonatomic) CoffeeModel *coffeeModel;

@property (strong, nonatomic) NSString *choiceProperty;
@property (strong, nonatomic) NSString *choiceLabel;
@property (nonatomic) NSInteger currentIndex;

@end
