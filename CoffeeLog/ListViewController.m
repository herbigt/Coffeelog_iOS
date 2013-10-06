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
        c1.store = @"Kafeee Koojntor";
        c1.price = 799;
        c1.weight = 250;
        c1.isFavorited = YES;
        
        CoffeeModel *c2 = [[CoffeeModel alloc] init];
        c2.image = [UIImage imageNamed:@"testimage"];
        c2.name = @"Frische Hühnerbrühe";
        c2.type = @"Tütensuppe";
        c2.store = @"web.de";
        c2.price =  1009;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *settings = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(openSettings:)];
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
    
}

- (void)addCoffee:(id)sender {
    
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
