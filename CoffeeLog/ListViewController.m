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


@end

@implementation ListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.coffeeList = [NSMutableArray array];
        
        CoffeeModel *c1 = [[CoffeeModel alloc] init];
        c1.image = [UIImage imageNamed:@"testimage"];
        c1.name = @"Espresso Excelsior";
        c1.type = @"Espresso";
        c1.state = @"Roasted Beans";
        c1.store = @"Kafeee Koojntor";
        c1.foursquareID = @"3fd66200f964a520c5e31ee3";
        c1.storeType = CoffeeStoreTypeLocation;
        c1.price = 799;
        c1.worksWith = @[@"sieb", @"turkish"];
        c1.weight = 250;
        c1.isFavorited = YES;
        
        CoffeeModel *c2 = [[CoffeeModel alloc] init];
        c2.image = nil;
        c2.name = @"Frische Hühnerbrühe";
        c2.state = @"Hühnchenbeine";
        c2.type = @"Tütensuppe";
        c2.store = @"web.de";
        c2.storeType = CoffeeStoreTypeWeb;
        c2.price =  1009;
        c2.worksWith = @[@"aero"];
        c2.weight = 350;
        c2.isFavorited = NO;
        
        [self.coffeeList addObject:c1];
        [self.coffeeList addObject:c2];
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
    
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if(self.coffeeList.count == 0) {
        self.tableView.separatorColor = [UIColor whiteColor];
        self.tableView.scrollEnabled = NO;
        
        UILabel *emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, self.view.bounds.size.width - 80, self.view.bounds.size.height - 60)];
        emptyLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:34.0f];
        emptyLabel.textColor = UIColorFromRGB(0x8e8e93);
        emptyLabel.numberOfLines = 3;
        emptyLabel.textAlignment = NSTextAlignmentCenter;
        emptyLabel.text = NSLocalizedString(@"Welcome, tap here to add your first coffee!", nil);
        emptyLabel.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addCoffee:)];
        [emptyLabel addGestureRecognizer:tgr];
        emptyLabel.userInteractionEnabled = YES;
        
        [self.tableView addSubview:emptyLabel];
    }
    
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
    UINavigationController *aevc = [[UINavigationController alloc] initWithRootViewController:[[AddEditViewController alloc] initWithCoffeeModel:[[CoffeeModel alloc] init]]];
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
