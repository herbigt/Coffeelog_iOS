//
//  AddEditViewController.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 14.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "AddEditViewController.h"

#import "WorksWithCollectionView.h"

@interface AddEditViewController ()

@property (strong, nonatomic) UIImageView *coffeeImageView;

@property (strong, nonatomic) NSArray *typesArray;
@property (strong, nonatomic) NSArray *statesArray;
@property (strong, nonatomic) NSArray *worksWithArray;

@end

@implementation AddEditViewController

-(id)initWithCoffeeModel:(CoffeeModel *)coffeeModel {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if(self) {
         _coffeeModel = coffeeModel;
        
        self.typesArray = @[@"Espresso", @"Coffee", @"Blend"];
        self.statesArray = @[@"Grinded", @"Beans (roasted)", @"Beans (unroasted)"];
        self.worksWithArray = @[@"aero", @"filter", @"frenchpress", @"sieb", @"turkish"];
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorColor = UIColorFromRGB(0xb57252);
    
    
    self.coffeeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
    
    UILabel *noImageLabel = [[UILabel alloc] initWithFrame:self.coffeeImageView.bounds];
    noImageLabel.text = @"Tap to add image";
    noImageLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:32];
    noImageLabel.textColor = UIColorFromRGB(0x8e8e93);
    noImageLabel.backgroundColor = [UIColor clearColor];
    noImageLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.coffeeImageView addSubview:noImageLabel];
    
    
    self.tableView.tableHeaderView = self.coffeeImageView;
    
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(openSettings:)];
    add.tintColor = [UIColor whiteColor];
     
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationItem.backBarButtonItem.title = @"Coffee Log";
    
    self.tableView.backgroundColor = UIColorFromRGB(0xffffff);
    
    
    [self.navigationItem setRightBarButtonItem:add];
    
	[self.navigationController setNavigationBarHidden:NO];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 5) {
        return 95;
    }
    
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 1) {
        return self.typesArray.count;
    }
    
    if(section == 2) {
        return self.statesArray.count;
    }
    
    if(section == 3) {
        return 2;
    }
    
    if(section == 4) {
        return 2;
    }
    
    if (section == 5) {
        return 1;
    }
    
    return 2;
}



-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 1) {
        return @"Type";
    }
    
    if(section == 2) {
        return @"State";
    }
    
    if(section == 3) {
        return @"Bought at";
    }
    
    if(section == 4) {
        return @"Price & Weight";
    }
    
    if(section == 5) {
        return @"Works with";
    }
    
    return @"";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *title = [self tableView:tableView titleForHeaderInSection:section];
    
    UIView *headerView = [[UIView alloc] init];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 3, self.view.bounds.size.width, 35)];
    titleLabel.text = title;
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Regular" size:14];
    titleLabel.textColor = UIColorFromRGB(0x000000);
    
    [headerView addSubview:titleLabel];
    
    return headerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat paddingLeft = 16;
    CGFloat cellHeight = [self tableView:tableView heightForRowAtIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    if(indexPath.section == 0) {
        if(indexPath.row == 0) {
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(paddingLeft, 0, 294, cellHeight)];
            textField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
            textField.textColor = UIColorFromRGB(0x8e8e93);
            textField.placeholder = @"Name";
            [cell addSubview:textField];
        } else if (indexPath.row == 1) {
            UILabel *favLabel = [[UILabel alloc] initWithFrame:CGRectMake(paddingLeft, 0, 250, cellHeight)];
            favLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
            favLabel.textColor = UIColorFromRGB(0x61605e);
            favLabel.text = @"Favorite";
            
            CGFloat switchY = cellHeight/2 - 31/2;
            UISwitch *favSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(255, switchY, 52, 31)];
            
            [cell addSubview:favLabel];
            [cell addSubview:favSwitch];
        }
        
        return cell;
    }
    
    if(indexPath.section == 1) {
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(paddingLeft, 0, 250, cellHeight)];
        typeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        typeLabel.textColor = UIColorFromRGB(0x61605e);
        typeLabel.text = self.typesArray[indexPath.row];
        
        [cell addSubview:typeLabel];
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        return cell;
    }
    
    if(indexPath.section == 2) {
        UILabel *stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(paddingLeft, 0, 250, cellHeight)];
        stateLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        stateLabel.textColor = UIColorFromRGB(0x61605e);
        stateLabel.text = self.statesArray[indexPath.row];
        
        [cell addSubview:stateLabel];
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        return cell;
    }
    
    
    if(indexPath.section == 3) {
        UILabel *boughtLabel = [[UILabel alloc] initWithFrame:CGRectMake(paddingLeft, 0, 250, cellHeight)];
        boughtLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        boughtLabel.textColor = UIColorFromRGB(0x8e8e93);
        [cell addSubview:boughtLabel];

        if(indexPath.row == 0) {
            boughtLabel.text = @"Location";
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            boughtLabel.text = @"Website";
        }
        
        
        return cell;
    }
    
    if(indexPath.section == 4) {
        UITextField *unitField = [[UITextField alloc] initWithFrame:CGRectMake(paddingLeft, 0, 60, cellHeight)];
        unitField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        unitField.textColor = UIColorFromRGB(0x8e8e93);
        
        UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 25, cellHeight)];
        unitLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        unitLabel.textColor = UIColorFromRGB(0x61605e);
        
        [cell addSubview:unitField];
        [cell addSubview:unitLabel];
        
        if(indexPath.row == 0) {
            unitField.placeholder = @"Price";
            unitLabel.text = @"€";
        } else {
            unitField.placeholder = @"Weight";
            unitLabel.text = @"g";
        }
        
        
        return cell;
    }
    
    if(indexPath.section == 5) {
        NSLog(@"cellheight: %f", cellHeight);
        WorksWithCollectionView *wwcv = [[WorksWithCollectionView alloc] initWithFrame:CGRectMake(paddingLeft, paddingLeft, self.view.bounds.size.width - paddingLeft*2, cellHeight - paddingLeft)];
        
        [wwcv setTypesArray:self.worksWithArray];
        
        [cell addSubview:wwcv];
    }
    
    return cell;
    
    
}

@end
