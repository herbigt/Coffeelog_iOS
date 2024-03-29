//
//  DetailViewController.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 06.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "DetailViewController.h"

#import <QuartzCore/QuartzCore.h>
#import <DMActivityInstagram/DMActivityInstagram.h>
#import "AddEditViewController.h"
#import "UserSettings.h"
#import "WorksWithCollectionView.h"


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
        

        
    }
    return self;
}

- (void)shareButton:(id)sender {
    NSLog(@"Share!");
    
    DMActivityInstagram *instagramActivity = [[DMActivityInstagram alloc] init];
    
    NSMutableArray *activityItems = @[].mutableCopy;
    if(self.coffeeModel.image) {
        [activityItems addObject:self.coffeeModel.image];
    }
    
    [activityItems addObject:self.coffeeModel.name];

    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:@[instagramActivity]];
    activityViewController.excludedActivityTypes = @[UIActivityTypePostToWeibo, UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypePrint, UIActivityTypeSaveToCameraRoll];

    [activityViewController setCompletionHandler:^void(NSString *activityType, BOOL completed) {
        if(!completed) {
            return;
        }
        
        NSString *action = @"Unknown";
        if([activityType isEqualToString:UIActivityTypePostToFacebook]) {
            action = kTrackingEventCoffeeShareEventFacebook;
        }
        
        if([activityType isEqualToString:UIActivityTypePostToTwitter]) {
            action = kTrackingEventCoffeeShareEventTwitter;
        }
        
        if([activityType isEqualToString:@"UIActivityTypePostToInstagram"]) {
            action = kTrackingEventCoffeeShareEventInstagram;
        }
        
        [TrackingHelper trackEvent:kTrackingEventCoffeeShareEvent withLabel:action];
        
    }];
    
    [self presentViewController:activityViewController animated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    if(![self.coffeeModel.imagePath isEqualToString:@""]) {
        self.coffeeImageView.image = [UIImage imageWithContentsOfFile:self.coffeeModel.imagePath];
    }
    
    [self.tableView reloadData];
    
    [TrackingHelper trackScreen:kTrackingScreenDetailView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.favoriteIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"favorite_detail"]];
    self.favoriteIcon.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.storeIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"web_detail"]];
    
    self.tableView.separatorColor = UIColorFromRGB(0xb57252);
    
    self.coffeeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];

    self.tableView.tableHeaderView = self.coffeeImageView;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 135)];
    self.shareButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.shareButton addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.shareButton setTintColor:UIColorFromRGB(0xff9500)];
    [self.shareButton setTitle:NSLocalizedString(@"Share this Coffee", nil) forState:UIControlStateNormal];
    self.shareButton.frame = CGRectMake(footerView.bounds.size.width/2 - 290/2, footerView.bounds.size.height/2 - 50/2, 290, 50);
    
    self.shareButton.layer.cornerRadius = 3.0f;
    self.shareButton.layer.borderColor = UIColorFromRGB(0xff9500).CGColor;
    self.shareButton.layer.borderWidth = 1.0f;

    [footerView addSubview:self.shareButton];
    
    self.tableView.tableFooterView = footerView;


    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Edit", nil) style:UIBarButtonItemStylePlain target:self action:@selector(openEdit:)];
    add.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationItem.backBarButtonItem.title = NSLocalizedString(@"Coffee Log", nil);

    
    [self.navigationItem setRightBarButtonItem:add];
    
	[self.navigationController setNavigationBarHidden:NO];
 
}

- (void)openEdit:(id)sender {
    UINavigationController *aevc = [[UINavigationController alloc] initWithRootViewController:[[AddEditViewController alloc] initWithCoffeeModel:self.coffeeModel]];
    [self presentViewController:aevc animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        return 65;
    }
    
    if(indexPath.row == 1) {
        return 75;
    }
    
    if(![self.coffeeModel.notes isEqualToString:@""] && indexPath.row == 4) {
        return [self heightForNoteCell];
    }
    
    if(([self.coffeeModel.notes isEqualToString:@""] && indexPath.row == 4) || indexPath.row == 5) {
        if(self.coffeeModel.worksWith.count > 4) {
            return 210;
        } else {
            return 140;
        }
    }
    
    return 50;
}

- (CGFloat)heightForNoteCell {
    static UITableViewCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [[UITableViewCell alloc] init];
    });
    
    
    
    sizingCell.textLabel.text = self.coffeeModel.notes;
    sizingCell.textLabel.numberOfLines = 0;
    
    CGSize size = [sizingCell systemLayoutSizeFittingSize:UILayoutFittingExpandedSize];
    return MAX(65, size.height);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.coffeeModel.notes isEqualToString:@""] ? 5 : 6;
}

// Whoa, das ist echt nicht so hübsch gemacht, funktioniert aber. Naja.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [self tableView:tableView heightForRowAtIndexPath:indexPath];
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.textLabel.textColor = UIColorFromRGB(0x61605e);
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(indexPath.row == 0) {
        cell.textLabel.text = self.coffeeModel.name;
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:24.0];
        
        self.favoriteIcon.frame = CGRectMake(MAX_X(cell) - self.favoriteIcon.bounds.size.width - 15, (height/2) - (self.favoriteIcon.bounds.size.height/2), self.favoriteIcon.bounds.size.width, self.favoriteIcon.bounds.size.height);
        self.favoriteIcon.hidden = !self.coffeeModel.isFavorited;
        [cell addSubview:self.favoriteIcon];
        
        [cell addConstraint:[NSLayoutConstraint constraintWithItem:self.favoriteIcon attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-40]];
        [cell addConstraint:[NSLayoutConstraint constraintWithItem:self.favoriteIcon attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        
    } else if (indexPath.row == 1) {
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 12, self.view.bounds.size.width, 20)];
        typeLabel.textColor = UIColorFromRGB(0x61605e);
        typeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0];
        typeLabel.text = [CoffeeModel labelForCoffeeType:self.coffeeModel.type];
        [typeLabel sizeToFit];
        
        UILabel *stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, MAX_Y(typeLabel) + 5, self.view.bounds.size.width, 20)];
        stateLabel.textColor = UIColorFromRGB(0x61605e);
        stateLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0];
        stateLabel.text = [CoffeeModel labelForCoffeeState:self.coffeeModel.state];
        [stateLabel sizeToFit];
  
        [cell addSubview:typeLabel];
        [cell addSubview:stateLabel];

        
    } else if (indexPath.row == 2) {
        self.storeIcon.image = self.coffeeModel.storeType == CoffeeStoreTypeWeb ? [UIImage imageNamed:@"web_detail"] : [UIImage imageNamed:@"location_detail"];
        self.storeIcon.frame = CGRectMake(15, (height/2) - (self.storeIcon.image.size.height/2), self.storeIcon.image.size.width, self.storeIcon.image.size.height);
        [cell addSubview:self.storeIcon];
        
        UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(MAX_X(self.storeIcon) + 5, 0, self.view.bounds.size.width - MAX_X(self.storeIcon) * 2 - 5, height)];
        locationLabel.text = self.coffeeModel.store;
        locationLabel.textColor = UIColorFromRGB(0x61605e);
        locationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0];
        
        [cell addSubview:locationLabel];
    
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    } else if (indexPath.row == 3) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ / %@", [[UserSettings defaultSettings] currencyString:self.coffeeModel.price], [[UserSettings defaultSettings] weightString:self.coffeeModel.weight]];
    } else if (![self.coffeeModel.notes isEqualToString:@""] && indexPath.row == 4) {
        cell.textLabel.text = self.coffeeModel.notes;
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0];
        cell.textLabel.numberOfLines = 0;
    }
    else if (([self.coffeeModel.notes isEqualToString:@""] && indexPath.row == 4) || indexPath.row == 5) {
        UILabel *worksWithLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 12, self.view.bounds.size.width, 20)];
        worksWithLabel.textColor = UIColorFromRGB(0x61605e);
        worksWithLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0];
        worksWithLabel.text = NSLocalizedString(@"Works with", nil);
        [worksWithLabel sizeToFit];
        
        [cell addSubview:worksWithLabel];
        
        WorksWithCollectionView *wwcv = [[WorksWithCollectionView alloc] initWithFrame:CGRectMake(15, MAX_Y(worksWithLabel) + 35, self.view.bounds.size.width - 15 * 2, height - MAX_Y(worksWithLabel) - 35)];
        
        
        [wwcv setActiveTypes:self.coffeeModel.worksWith];
        [wwcv setTypesArray:self.coffeeModel.worksWith];
        wwcv.isEditable = NO;
        
        wwcv.tintColor = UIColorFromRGB(0x605f5e);
        
        [cell addSubview:wwcv];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 2) {
        NSArray *testURLs = nil;
        
        if(self.coffeeModel.storeType == CoffeeStoreTypeWeb) {
            NSString *urlString = [self.coffeeModel.store stringByReplacingOccurrencesOfString:@"http://" withString:@""];
            urlString = [urlString stringByReplacingOccurrencesOfString:@"Http://" withString:@""];
            
            testURLs = @[[NSURL URLWithString:[NSString stringWithFormat:@"http://%@", urlString]]];
        } else {
            testURLs = @[[NSURL URLWithString:[NSString stringWithFormat:@"foursquare://venues/%@", self.coffeeModel.foursquareID]], [NSURL URLWithString:[NSString stringWithFormat:@"http://foursquare.com/venue/%@", self.coffeeModel.foursquareID]]];
        }
        
        for(NSURL *url in testURLs) {
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
                return;
            }
        }
    }
}

@end
