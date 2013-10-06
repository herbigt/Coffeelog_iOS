//
//  DetailViewController.h
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 06.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CoffeeModel.h"

@interface DetailViewController : UITableViewController

@property (strong, nonatomic) CoffeeModel *coffeeModel;

- (id)initWithCoffeeModel:(CoffeeModel*)coffeeModel;

@end
