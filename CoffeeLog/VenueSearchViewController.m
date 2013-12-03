//
//  VenueSearchViewController.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 27.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "VenueSearchViewController.h"
#import "FoursquareVenueProvider.h"
#import "VenueCell.h"

@interface VenueSearchViewController ()

@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *lastLocation;
@property (strong, nonatomic) NSMutableArray *searchResults;

@end

@implementation VenueSearchViewController

- (id)initWithCoffeeModel:(CoffeeModel *)model
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.coffeeModel = model;
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
        [self.locationManager startUpdatingLocation];
        
        self.searchResults = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc {
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"Current Location: %@", [locations lastObject]);
    self.lastLocation = [locations lastObject];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
 
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = NSLocalizedString(@"Search for a place", nil);
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.tintColor = UIColorFromRGB(0xFF9500);
    
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", nil) style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
    cancel.tintColor = [UIColor whiteColor];
    
    [self.navigationItem setLeftBarButtonItem:cancel];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1 green:139/255.0 blue:0 alpha:0.65];
    self.navigationController.navigationBar.translucent = YES;
    
    
    [self.tableView registerClass:[VenueCell class] forCellReuseIdentifier:@"Cell"];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    UIImageView *poweredByView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"powered_by_4sq"]];
    poweredByView.center = footerView.center;
    [footerView addSubview:poweredByView];
    
    self.tableView.tableFooterView = footerView;
}

- (void)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.searchBar becomeFirstResponder];
    
    [TrackingHelper trackScreen:kTrackingScreenVenueSearchView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.searchBar resignFirstResponder];
}


#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    
    [[FoursquareVenueProvider defaultProvider] searchVenuesWithTerm:searchBar.text andLocation:self.lastLocation andCompletionBlock:^(NSError *error, NSArray *venues) {
        if(error) {
            NSLog(@"%@", error);
            return;
        }
        
        [self.searchResults removeAllObjects];
        [self.searchResults addObjectsFromArray:venues];
    
        [self.tableView reloadData];
    }];
    
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    VenueCell *cell = (VenueCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell setVenue:self.searchResults[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *venue = self.searchResults[indexPath.row];
    
    self.coffeeModel.storeType = CoffeeStoreTypeLocation;
    self.coffeeModel.storeLatitude = [venue[@"location"][@"lat"] doubleValue];
    self.coffeeModel.storeLongitude = [venue[@"location"][@"lng"] doubleValue];
    self.coffeeModel.foursquareID = venue[@"id"];
    self.coffeeModel.store = venue[@"name"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
