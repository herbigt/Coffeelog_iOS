//
//  DetailViewController.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 06.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "DetailViewController.h"

#import <QuartzCore/QuartzCore.h>



@interface DetailViewController ()

@property (strong, nonatomic) UIImageView *coffeeImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *typeLabel;
@property (strong, nonatomic) UILabel *stateLabel;
@property (strong, nonatomic) UIImageView *storeIcon;
@property (strong, nonatomic) UILabel *storeLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UIImageView *favoriteIcon;
@property (strong, nonatomic) UILabel *worksWithLabel;
@property (strong, nonatomic) UICollectionView *worksWithView;
@property (strong, nonatomic) UIButton *shareButton;

@end

@implementation DetailViewController

- (id)initWithCoffeeModel:(CoffeeModel*)coffeeModel
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _coffeeModel = coffeeModel;
        
        self.favoriteIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"favorite"]];
        self.storeIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location"]];
        
           }
    return self;
}

- (void)shareButton:(id)sender {
    NSLog(@"Share!");
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorColor = UIColorFromRGB(0xb57252);
    
    self.coffeeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
    self.coffeeImageView.image = self.coffeeModel.image;
    self.tableView.tableHeaderView = self.coffeeImageView;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 135)];
    self.shareButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.shareButton addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.shareButton setTintColor:UIColorFromRGB(0xff9500)];
    [self.shareButton setTitle:@"Share this Coffee" forState:UIControlStateNormal];
    self.shareButton.frame = CGRectMake(footerView.bounds.size.width/2 - 290/2, footerView.bounds.size.height/2 - 50/2, 290, 50);
    
    self.shareButton.layer.cornerRadius = 3.0f;
    self.shareButton.layer.borderColor = UIColorFromRGB(0xff9500).CGColor;
    self.shareButton.layer.borderWidth = 1.0f;

    [footerView addSubview:self.shareButton];
    
    self.tableView.tableFooterView = footerView;


    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(openSettings:)];
    add.tintColor = [UIColor whiteColor];
       self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};    
    self.navigationItem.backBarButtonItem.title = @"Coffee Log";

    
    [self.navigationItem setRightBarButtonItem:add];
    
	[self.navigationController setNavigationBarHidden:NO];
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 4 || indexPath.row == 1) {
        return 80;
    }
    
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [self tableView:tableView heightForRowAtIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, height)];
    cell.textLabel.textColor = UIColorFromRGB(0x61605e);
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(indexPath.row == 0) {
        cell.textLabel.text = self.coffeeModel.name;
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:24.0];
        
        self.favoriteIcon.frame = CGRectMake(MAX_X(cell) - self.favoriteIcon.bounds.size.width - 15, (cell.bounds.size.height/2) - (self.favoriteIcon.bounds.size.height/2), self.favoriteIcon.bounds.size.width, self.favoriteIcon.bounds.size.height);
        [cell addSubview:self.favoriteIcon];
    } else if (indexPath.row == 1) {
        cell.textLabel.text =  [NSString stringWithFormat:@"%@\n%@", self.coffeeModel.type, self.coffeeModel.type];
        cell.textLabel.numberOfLines = 2;
        
    } else if (indexPath.row == 2) {
        self.storeIcon.frame = CGRectMake(15, (cell.bounds.size.height/2) - (self.storeIcon.bounds.size.height/2), self.storeIcon.bounds.size.width, self.storeIcon.bounds.size.height);
        [cell addSubview:self.storeIcon];
        
        cell.textLabel.text = self.coffeeModel.store;
        cell.textLabel.frame = CGRectMake(MAX_X(self.storeIcon) + 5, cell.textLabel.frame.origin.y, cell.textLabel.bounds.size.width - MAX_X(self.storeIcon), cell.textLabel.bounds.size.height);
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    } else if (indexPath.row == 3) {
        cell.textLabel.text = [NSString stringWithFormat:@"%.2f€ / %.2fg", (self.coffeeModel.price/100.0f), (self.coffeeModel.weight/100.0f)];
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"Works with";
    }
    
    return cell;
}

@end
