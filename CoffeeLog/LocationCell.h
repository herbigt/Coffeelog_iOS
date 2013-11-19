//
//  LocationCell.h
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 19.11.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "CoffeeModel.h"

@interface LocationCell : UITableViewCell <UITextFieldDelegate>


@property (strong, nonatomic) CoffeeModel *coffeeModel;
@property (nonatomic) BOOL isWebsite;

@end
