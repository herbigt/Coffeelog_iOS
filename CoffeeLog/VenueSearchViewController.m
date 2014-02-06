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
#import "CLNavigationBar.h"

@interface VenueSearchViewController ()

@property (strong, nonatomic) UISearchBar *currentSearchBar;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UISearchBar *searchBarNear;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *lastLocation;
@property (strong, nonatomic) NSMutableArray *searchResults;
@property (strong, nonatomic) UIView *searchNearView;
@property (strong, nonatomic) UILabel *searchNearLabel;
@property (strong, nonatomic) NSDictionary *currentPosition;

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
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.tag = 300;
    self.searchBar.delegate = self;
    self.searchBar.placeholder = NSLocalizedString(@"Search for a place", nil);
    self.searchBar.tintColor = UIColorFromRGB(0xFF9500);
    
    self.navigationItem.titleView = self.searchBar;
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", nil) style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
    cancel.tintColor = [UIColor whiteColor];
    
    [self.navigationItem setLeftBarButtonItem:cancel];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1 green:139/255.0 blue:0 alpha:0.65];
    self.navigationController.navigationBar.translucent = YES;
 
    
    self.searchBarNear = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 250, 30)];
    self.searchBarNear.tag = 400;
    self.searchBarNear.delegate = self;
    self.searchBarNear.placeholder = @"Enter address or city name";
    self.searchBarNear.tintColor = UIColorFromRGB(0xFF9500);
    self.searchBarNear.hidden = YES;
    
    [self.navigationController.navigationBar addSubview:self.searchBarNear];
    
    self.searchNearView = [[UIView alloc] init];
    self.searchNearView.tag = 100;
    
    self.searchNearLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    self.searchNearLabel.text = @"Search near: Current position";
    self.searchNearLabel.textAlignment = NSTextAlignmentCenter;
    self.searchNearLabel.textColor = [UIColor whiteColor];
    self.searchNearLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0f];
    
    [self.searchNearView addSubview:self.searchNearLabel];
    
    UIImageView *locationArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location_arrow"]];
    locationArrow.frame = CGRectMake(50, 0, locationArrow.bounds.size.width, 44);
    locationArrow.contentMode = UIViewContentModeCenter;
    
    [self.searchNearView addSubview:locationArrow];

    UIImageView *disclosure = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"disclose_button"]];
    disclosure.frame = CGRectMake(self.view.bounds.size.width - 20, 0, disclosure.bounds.size.width, 44);
    disclosure.contentMode = UIViewContentModeCenter;
    
    [self.searchNearView addSubview:disclosure];
    
    [self.navigationController.navigationBar addSubview:self.searchNearView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSearchNearSearchInput:)];
    self.searchNearLabel.userInteractionEnabled = YES;
    [self.searchNearLabel addGestureRecognizer:tapGesture];
    
    [self.tableView registerClass:[VenueCell class] forCellReuseIdentifier:@"Cell"];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    UIImageView *poweredByView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"powered_by_4sq"]];
    poweredByView.center = footerView.center;
    [footerView addSubview:poweredByView];
    
    self.tableView.tableFooterView = footerView;
}

- (void)showSearchNearSearchInput:(id)sender {
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 35)];
    titleView.tag = 200;
    titleView.font = [UIFont systemFontOfSize:18];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.textColor = [UIColor whiteColor];
    titleView.text = @"Change Position";
    
    self.navigationItem.titleView = titleView;
    
    self.searchBarNear.hidden = NO;
    [self.searchBarNear becomeFirstResponder];

    self.searchNearView.hidden = YES;
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
    self.currentSearchBar = searchBar;
    
    [searchBar resignFirstResponder];
    
    CLLocation *location = self.lastLocation;
    if(self.currentPosition) {
        location = [[CLLocation alloc] initWithLatitude:[self.currentPosition[@"location"][@"lat"] doubleValue] longitude:[self.currentPosition[@"location"][@"lng"] doubleValue]];
    }
    
    if(searchBar == self.searchBar) {
        [[FoursquareVenueProvider defaultProvider] searchVenuesWithTerm:searchBar.text andLocation:location andCompletionBlock:^(NSError *error, NSArray *venues) {
            if(error) {
                NSLog(@"%@", error);
                return;
            }
            
            
            
            [self.searchResults removeAllObjects];
            [self.searchResults addObjectsFromArray:venues];
            
            [self.tableView reloadData];
        }];
    } else {
        [[FoursquareVenueProvider defaultProvider] searchVenuesWithTerm:searchBar.text andCompletionBlock:^(NSError *error, NSArray *venues) {
            if(error) {
                NSLog(@"%@", error);
                return;
            }
            
            self.searchResults = [NSMutableArray arrayWithArray:venues];
        
            [self.tableView reloadData];
        }];
    }
    

    
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

    if(self.currentSearchBar == self.searchBarNear) {
        self.searchBarNear.hidden = YES;
        self.searchNearLabel.text = [NSString stringWithFormat:@"Search near: %@", venue[@"name"]];
        self.searchNearView.hidden = NO;
        
        self.currentPosition = venue;
        
        self.navigationItem.titleView = self.searchBar;
        
        [self.searchBar becomeFirstResponder];
    
        [self.searchResults removeAllObjects];
        [self.tableView reloadData];
    } else {
        
        self.coffeeModel.storeType = CoffeeStoreTypeLocation;
        self.coffeeModel.storeLatitude = [venue[@"location"][@"lat"] doubleValue];
        self.coffeeModel.storeLongitude = [venue[@"location"][@"lng"] doubleValue];
        self.coffeeModel.foursquareID = venue[@"id"];
        self.coffeeModel.store = venue[@"name"];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
