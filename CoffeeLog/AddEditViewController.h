//
//  AddEditViewController.h
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 14.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CoffeeModel.h"

@interface AddEditViewController : UITableViewController <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) CoffeeModel *coffeeModel;

- (id)initWithCoffeeModel:(CoffeeModel*)coffeeModel;

@end
