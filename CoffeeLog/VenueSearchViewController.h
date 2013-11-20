//
//  VenueSearchViewController.h
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 27.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "CoffeeModel.h"

@interface VenueSearchViewController : UITableViewController <UISearchBarDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) CoffeeModel *coffeeModel;

- (id)initWithCoffeeModel:(CoffeeModel*)model;

@end
