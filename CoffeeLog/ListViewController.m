//
//  ListViewController.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 06.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "ListViewController.h"

#import "CoffeeModel.h"
#import "CoffeeListCell.h"
#import "DetailViewController.h"
#import "AddEditViewController.h"
#import "SettingsViewController.h"

@interface ListViewController ()

@property (strong, nonatomic) NSMutableArray *coffeeList;

@property (strong, nonatomic) UILabel *emptyLabel;


@end

@implementation ListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.coffeeList = [NSMutableArray array];
    }
    
    return self;
}

- (void)loadView {
    [super loadView];
    
 
    [self.tableView registerClass:[CoffeeListCell class] forCellReuseIdentifier:@"CoffeeListCell"];
    self.tableView.separatorColor = UIColorFromRGB(0xb57252);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    [self reloadListData];
    
    if(self.coffeeList.count == 0) {
        self.tableView.separatorColor = [UIColor whiteColor];
        self.tableView.scrollEnabled = NO;
        
        if(!self.emptyLabel) {
            self.emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, self.view.bounds.size.width - 80, self.view.bounds.size.height - 60)];
            self.emptyLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:34.0f];
            self.emptyLabel.textColor = UIColorFromRGB(0x8e8e93);
            self.emptyLabel.numberOfLines = 3;
            self.emptyLabel.textAlignment = NSTextAlignmentCenter;
            self.emptyLabel.text = NSLocalizedString(@"Welcome, tap here to add your first coffee!", nil);
            self.emptyLabel.backgroundColor = [UIColor whiteColor];
            
            UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addCoffee:)];
            [self.emptyLabel addGestureRecognizer:tgr];
            self.emptyLabel.userInteractionEnabled = YES;
            
            self.emptyLabel.hidden = YES;
            
            [self.tableView addSubview:self.emptyLabel];
        }
        
        self.emptyLabel.hidden = NO;
    } else {
        self.emptyLabel.hidden = YES;
        self.tableView.separatorColor = UIColorFromRGB(0xb57252);
        self.tableView.scrollEnabled = YES;
    }
}

- (void) reloadListData {
    [self.coffeeList removeAllObjects];
    [self.coffeeList addObjectsFromArray:[CoffeeModel instancesWhere:nil]];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *settings = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Settings", nil) style:UIBarButtonItemStylePlain target:self action:@selector(openSettings:)];
    settings.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add"] style:UIBarButtonItemStylePlain target:self action:@selector(addCoffee:)];
    add.tintColor = [UIColor whiteColor];
    
    [self.navigationItem setLeftBarButtonItem:settings];
    [self.navigationItem setRightBarButtonItem:add];
    
	[self.navigationController setNavigationBarHidden:NO];
    [self setTitle:@"Coffee Log"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
}

- (void)openSettings:(id)sender {
    UINavigationController *snc = [[UINavigationController alloc] initWithRootViewController:[[SettingsViewController alloc] init]];
    [self presentViewController:snc animated:YES completion:nil];
}

- (void)addCoffee:(id)sender {
    UINavigationController *aevc = [[UINavigationController alloc] initWithRootViewController:[[AddEditViewController alloc] initWithCoffeeModel:[CoffeeModel new]]];
    [self presentViewController:aevc animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 115.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self coffeeList] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CoffeeListCell *clc = [tableView dequeueReusableCellWithIdentifier:@"CoffeeListCell"];
    
    [clc setCoffeeModel:[self.coffeeList objectAtIndex:indexPath.row]];
    
    return clc;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CoffeeModel *model = [self.coffeeList objectAtIndex:indexPath.row];
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithCoffeeModel:model];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
