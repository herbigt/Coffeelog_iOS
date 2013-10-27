//
//  SettingsViewController.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 20.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (strong, nonatomic) NSArray *sectionArray;
@property (strong, nonatomic) NSArray *currencyArray;
@property (strong, nonatomic) NSArray *weightArray;
@property (strong, nonatomic) NSArray *followArray;

@end

@implementation SettingsViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.sectionArray = @[@"Currency", @"Weight", @"Backup", @"Follow"];
        self.currencyArray = @[@"EUR", @"USD", @"GBP"];
        self.weightArray = @[@"g", @"lb"];
        self.followArray = @[@"herbigt", @"knuspermagier"];
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0xff9500);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(saveAndClose:)];
    add.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x8e8e93);
    
    [self.navigationItem setRightBarButtonItem:add];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationItem.backBarButtonItem.title = @"Settings";
    
    self.tableView.backgroundColor = UIColorFromRGB(0x8e8e93);
    self.tableView.separatorColor = UIColorFromRGB(0xc8c8c8);
    self.tableView.tintColor = [UIColor whiteColor];
    
	[self.navigationController setNavigationBarHidden:NO];
    
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 55)];
    versionLabel.text = [NSString stringWithFormat:@"Coffeelog %@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
;
    versionLabel.textColor = UIColorFromRGB(0xffffff);
    versionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:32];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    
    self.tableView.tableFooterView = versionLabel;
}

- (void)saveAndClose:(id)sender {
    NSLog(@"save And Close");
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionArray[section];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) {
        return self.currencyArray.count;
    }
    
    if(section == 1) {
        return self.weightArray.count;
    }
    
    if(section == 3) {
        return self.followArray.count;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.backgroundColor = UIColorFromRGB(0x8e8e93);
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    cell.textLabel.textColor = UIColorFromRGB(0xffffff);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(indexPath.section == 0) {
        cell.textLabel.text = self.currencyArray[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else if (indexPath.section == 1) {
        cell.textLabel.text = self.weightArray[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;

    } else if (indexPath.section == 2) {
        cell.textLabel.text = @"Enable Dropbox Backup";
    } else if(indexPath.section == 3) {
        cell.textLabel.text = [NSString stringWithFormat:@"@%@", self.followArray[indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 3) {
        NSArray *testURLs = @[[NSURL URLWithString:[NSString stringWithFormat:@"twitter://user?screen_name=%@", self.followArray[indexPath.row]]], [NSURL URLWithString:[NSString stringWithFormat:@"tweetbot://%@/user_profile/%@", self.followArray[indexPath.row], self.followArray[indexPath.row]]], [NSURL URLWithString:[NSString stringWithFormat:@"https://twitter.com/%@", self.followArray[indexPath.row]]]];

        for(NSURL *url in testURLs) {
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
                return;
            }
        }
    }
}

@end
