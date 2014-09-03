//
//  NoteCellCell.h
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 03/09/14.
//  Copyright (c) 2014 CoffeeLog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoffeeModel.h"

@interface NoteCell : UITableViewCell <UITextViewDelegate>

@property (strong, nonatomic) CoffeeModel *coffeeModel;

@end
