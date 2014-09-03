//
//  AddEditViewController.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 14.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "AddEditViewController.h"

#import "WorksWithCollectionView.h"
#import "UserSettings.h"

#import "VenueSearchViewController.h"

#import "NameCell.h"
#import "FavoriteCell.h"
#import "ChooseCell.h"
#import "NumberCell.h"
#import "LocationCell.h"
#import "WorksWithCell.h"
#import "CLNavigationBar.h"
#import "NoteCell.h"

@interface AddEditViewController ()

@property (strong, nonatomic) UITapGestureRecognizer *dismissRecognizer;
@property (strong, nonatomic) UIImageView *coffeeImageView;
@property (strong, nonatomic) UILabel *noImageLabel;
@property (strong, nonatomic) NSArray *coffeeTypes;

@end

@implementation AddEditViewController

-(id)initWithCoffeeModel:(CoffeeModel *)coffeeModel {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if(self) {
         _coffeeModel = coffeeModel;
        self.coffeeTypes = [CoffeeModel coffeeTypes];
    }
    
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
    
    [TrackingHelper trackScreen:kTrackingScreenAddEditView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorColor = UIColorFromRGB(0xb57252);
    
    
    self.coffeeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
    
    self.noImageLabel = [[UILabel alloc] init];
    self.noImageLabel.frame = self.coffeeImageView.bounds;
    self.noImageLabel.text = NSLocalizedString(@"Tap to add image", nil);
    self.noImageLabel.textColor = UIColorFromRGB(0x8e8e93);
    self.noImageLabel.numberOfLines = 2;
    self.noImageLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:32];
    self.noImageLabel.backgroundColor = [UIColor clearColor];
    self.noImageLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.coffeeImageView addSubview:self.noImageLabel];
    
    [self.coffeeImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openImageActionSheet:)]];
    [self.noImageLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openImageActionSheet:)]];
    
    self.coffeeImageView.userInteractionEnabled = YES;
    self.noImageLabel.userInteractionEnabled = YES;
    
    self.tableView.tableHeaderView = self.coffeeImageView;
    

    [self.tableView registerClass:[NameCell class] forCellReuseIdentifier:@"NameCell"];
    [self.tableView registerClass:[FavoriteCell class] forCellReuseIdentifier:@"FavoriteCell"];
    [self.tableView registerClass:[ChooseCell class] forCellReuseIdentifier:@"ChooseCell"];
    [self.tableView registerClass:[NumberCell class] forCellReuseIdentifier:@"NumberCell"];
    [self.tableView registerClass:[LocationCell class] forCellReuseIdentifier:@"LocationCell"];
    [self.tableView registerClass:[WorksWithCell class] forCellReuseIdentifier:@"WorksWithCell"];
    [self.tableView registerClass:[NoteCell class] forCellReuseIdentifier:@"NoteCell"];
    
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Save", nil) style:UIBarButtonItemStylePlain target:self action:@selector(saveAndClose:)];
    add.tintColor = [UIColor whiteColor];
    
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", nil) style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
    cancel.tintColor = [UIColor whiteColor];
    
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationItem.backBarButtonItem.title = NSLocalizedString(@"Coffee Log", nil);
    
    self.tableView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.navigationItem setLeftBarButtonItem:cancel];
    [self.navigationItem setRightBarButtonItem:add];
    
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1 green:139/255.0 blue:0 alpha:0.65];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    self.dismissRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAllKeyboards:)];
 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    if(![self.coffeeModel.imagePath isEqualToString:@""]) {
        self.coffeeImageView.image = [UIImage imageWithContentsOfFile:self.coffeeModel.imagePath];
        self.noImageLabel.hidden = YES;
    }
   
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillShow:(NSNotification *)note {
    [self.view addGestureRecognizer:self.dismissRecognizer];
}

- (void)keyboardWillHide:(NSNotification *)note {
    [self.view removeGestureRecognizer:self.dismissRecognizer];
}

- (void)dismissAllKeyboards:(id)sender {
    [self.view endEditing:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 6) {
        return 175;
    }
    
    if(indexPath.section == 5) {
        return 175;
    }
    
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 1) {
        return [CoffeeModel coffeeTypes].count;
    }
    
    if(section == 2) {
        return [CoffeeModel coffeeStates].count;
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
    
    if (section == 6) {
        return 1;
    }
    
    return 2;
}



-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 1) {
        return NSLocalizedString(@"Type", nil);
    }
    
    if(section == 2) {
        return NSLocalizedString(@"State", nil);
    }
    
    if(section == 3) {
        return NSLocalizedString(@"Bought at", nil);
    }
    
    if(section == 4) {
        return NSLocalizedString(@"Price & Weight", nil);
    }
    
    if(section == 5) {
        return NSLocalizedString(@"Notes", nil);
    }
    
    if(section == 6) {
        return NSLocalizedString(@"Works with", nil);
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
    UITableViewCell *cell;
    
    if(indexPath.section == 0) {
        if(indexPath.row == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"NameCell"];
            ((NameCell*)cell).coffeeModel = self.coffeeModel;
            return cell;
        } else if (indexPath.row == 1) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"FavoriteCell"];
            ((NameCell*)cell).coffeeModel = self.coffeeModel;
            return cell;
        }
        
        return cell;
    }
    
    if(indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseCell"];
        ((ChooseCell*)cell).currentIndex = [self.coffeeTypes[indexPath.row] integerValue];
        ((ChooseCell*)cell).choiceProperty = @"type";
        ((ChooseCell*)cell).choiceLabel = [CoffeeModel labelForCoffeeType:[self.coffeeTypes[indexPath.row] integerValue]];
        ((ChooseCell*)cell).coffeeModel = self.coffeeModel;
        
        return cell;
    }
    
    if(indexPath.section == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseCell"];
        ((ChooseCell*)cell).currentIndex = indexPath.row;
        ((ChooseCell*)cell).choiceProperty = @"state";
        ((ChooseCell*)cell).choiceLabel = [CoffeeModel labelForCoffeeState:indexPath.row];
        ((ChooseCell*)cell).coffeeModel = self.coffeeModel;
        
        return cell;
    }
    
    
    if(indexPath.section == 3) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"LocationCell"];
        
        ((LocationCell*)cell).isWebsite = indexPath.row == 1;
        ((LocationCell*)cell).coffeeModel = self.coffeeModel;
        
        return cell;
    }
    
    if(indexPath.section == 4) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"NumberCell"];
        
        if(indexPath.row == 0) {
            ((NumberCell*)cell).numberProperty = @"price";
            ((NumberCell*)cell).numberPlaceholder =  NSLocalizedString(@"Price", nil);
            ((NumberCell*)cell).numberLabel = [UserSettings defaultSettings].currency;
            ((NumberCell*)cell).numberUnit = [UserSettings defaultSettings].currency;
        } else {
            ((NumberCell*)cell).numberProperty = @"weight";
            ((NumberCell*)cell).numberPlaceholder =  NSLocalizedString(@"Weight", nil);
            ((NumberCell*)cell).numberLabel = [UserSettings defaultSettings].weight;
            ((NumberCell*)cell).numberUnit = [UserSettings defaultSettings].weight;
        }

        ((NumberCell*)cell).coffeeModel = self.coffeeModel;

        return cell;
    }
    
    if(indexPath.section == 5) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"NoteCell"];
        ((WorksWithCell*)cell).coffeeModel = self.coffeeModel;
    }
    
    if(indexPath.section == 6) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"WorksWithCell"];
        ((WorksWithCell*)cell).coffeeModel = self.coffeeModel;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1) {
      //  self.coffeeModel.type = indexPath.row;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    
    if(indexPath.section == 2) {
    //    self.coffeeModel.state = indexPath.row;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    
    if(indexPath.section == 3) {
        if(indexPath.row == 0) {
            UINavigationController *nvc = [[UINavigationController alloc] initWithNavigationBarClass:[CLNavigationBar class] toolbarClass:[UIToolbar class]];
            nvc.viewControllers = @[[[VenueSearchViewController alloc] initWithCoffeeModel:self.coffeeModel]];
            [self.navigationController presentViewController:nvc animated:YES completion:nil];
            return;
        }
    }
}

- (void)openImageActionSheet:(id)sender {
    NSString *destructiveTitle = nil;
    if(self.coffeeImageView.image) {
        destructiveTitle = NSLocalizedString(@"Remove current", nil);
    }
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Choose image", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:destructiveTitle otherButtonTitles:NSLocalizedString(@"From camera", nil), NSLocalizedString(@"From library", nil), nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    
    if(buttonIndex == actionSheet.destructiveButtonIndex) {
        self.coffeeImageView.image = nil;
        self.noImageLabel.text = NSLocalizedString(@"Tap to add image", nil);
        self.noImageLabel.hidden = NO;
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.delegate = self;
    
    if(buttonIndex == actionSheet.firstOtherButtonIndex) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else if(buttonIndex == actionSheet.firstOtherButtonIndex + 1) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}


- (void)saveAndClose:(id)sender {
    [self.view endEditing:YES];
    
    NSString *label = (self.coffeeModel.existsInDatabase ? kTrackingEventCoffeeEventSaveExisting : kTrackingEventCoffeeEventSaveNew);
    if([CoffeeModel count] == 0) {
        label = kTrackingEventCoffeeEventSaveFirst;
    }
    
    [TrackingHelper trackEvent:kTrackingEventCoffeeEvent withLabel:label];
    
    if(!self.coffeeModel.created) {
        self.coffeeModel.created = [NSDate new];
    }
    
    [self.coffeeModel save];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.coffeeImageView.image = info[@"UIImagePickerControllerEditedImage"];
    self.noImageLabel.text = @"";
    
    [self.coffeeModel saveImage:info[@"UIImagePickerControllerEditedImage"]];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
