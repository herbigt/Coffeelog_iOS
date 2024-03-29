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

@property (strong, nonatomic) UIView *emptyView;


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
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
 
    [self.tableView registerClass:[CoffeeListCell class] forCellReuseIdentifier:@"CoffeeListCell"];
    self.tableView.separatorColor = UIColorFromRGB(0xb57252);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [TrackingHelper trackScreen:kTrackingScreenListView];
    
    [self reloadListData];
    
    if(self.coffeeList.count == 0) {
        self.tableView.separatorColor = [UIColor whiteColor];
        self.tableView.scrollEnabled = NO;
        
        if(!self.emptyView) {
            UILabel *emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, self.view.bounds.size.width - 80, self.view.bounds.size.height - 60)];
            emptyLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:34.0f];
            emptyLabel.textColor = UIColorFromRGB(0x8e8e93);
            emptyLabel.numberOfLines = 5;
            emptyLabel.textAlignment = NSTextAlignmentCenter;
            emptyLabel.text = NSLocalizedString(@"Welcome, tap here to add your first coffee!", nil);
            emptyLabel.backgroundColor = [UIColor whiteColor];

            self.emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 60)];
            self.emptyView.backgroundColor = [UIColor whiteColor];
            [self.emptyView addSubview:emptyLabel];
            
            UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addCoffee:)];
            [emptyLabel addGestureRecognizer:tgr];
            emptyLabel.userInteractionEnabled = YES;
            
            self.emptyView.hidden = YES;
            
            [self.tableView addSubview:self.emptyView];
        }
        
        self.emptyView.hidden = NO;
    } else {
        self.emptyView.hidden = YES;
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
    
    UIBarButtonItem *settings = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"] style:UIBarButtonItemStylePlain target:self action:@selector(openSettings:)];
    settings.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add_thick"] style:UIBarButtonItemStylePlain target:self action:@selector(addCoffee:)];
    add.tintColor = [UIColor whiteColor];
    
    [self.navigationItem setLeftBarButtonItem:settings];
    [self.navigationItem setRightBarButtonItem:add];
    
	[self.navigationController setNavigationBarHidden:NO];
    [self setTitle:NSLocalizedString(@"Coffee Log", nil)];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
}

- (void)openSettings:(id)sender {
    UINavigationController *snc = [[UINavigationController alloc] initWithRootViewController:[[SettingsViewController alloc] init]];
    [self presentViewController:snc animated:YES completion:nil];
}

- (void)addCoffee:(id)sender {
    [TrackingHelper trackEvent:kTrackingEventCoffeeEvent withLabel:self.coffeeList.count == 0 ? kTrackingEventCoffeeEventAddFirst : kTrackingEventCoffeeEventAdd];
    
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

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 && self.coffeeList.count != 0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        CoffeeModel *model = self.coffeeList[indexPath.row];
        [model delete];
        
        [self.coffeeList removeObjectAtIndex:indexPath.row];
        
        [TrackingHelper trackEvent:kTrackingEventCoffeeEvent withLabel:kTrackingEventCoffeeEventDelete];
        
        
        if(self.coffeeList.count == 0) {
            [self.tableView setEditing:NO animated:YES];
            [tableView reloadData];
        } else {
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
    }
}

@end
