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

@interface AddEditViewController ()

@property (strong, nonatomic) UIImageView *coffeeImageView;
@property (strong, nonatomic) UILabel *noImageLabel;

@end

@implementation AddEditViewController

-(id)initWithCoffeeModel:(CoffeeModel *)coffeeModel {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if(self) {
         _coffeeModel = coffeeModel;
    }
    
    return self;
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
    self.noImageLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:32];
    self.noImageLabel.backgroundColor = [UIColor clearColor];
    self.noImageLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.coffeeImageView addSubview:self.noImageLabel];
    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openImageActionSheet:)];
    [self.coffeeImageView addGestureRecognizer:tgr];
    [self.noImageLabel addGestureRecognizer:tgr];
    
    self.coffeeImageView.userInteractionEnabled = YES;
    self.noImageLabel.userInteractionEnabled = YES;
    
    self.tableView.tableHeaderView = self.coffeeImageView;
    

    [self.tableView registerClass:[NameCell class] forCellReuseIdentifier:@"NameCell"];
    [self.tableView registerClass:[FavoriteCell class] forCellReuseIdentifier:@"FavoriteCell"];
    [self.tableView registerClass:[ChooseCell class] forCellReuseIdentifier:@"ChooseCell"];
    [self.tableView registerClass:[NumberCell class] forCellReuseIdentifier:@"NumberCell"];
    [self.tableView registerClass:[LocationCell class] forCellReuseIdentifier:@"LocationCell"];
    [self.tableView registerClass:[WorksWithCell class] forCellReuseIdentifier:@"WorksWithCell"];
    
    
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


}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 5) {
        return 95;
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
        ((ChooseCell*)cell).currentIndex = indexPath.row;
        ((ChooseCell*)cell).choiceProperty = @"type";
        ((ChooseCell*)cell).choiceLabel = [CoffeeModel labelForCoffeeType:indexPath.row];
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
            ((NumberCell*)cell).numberLabel = [UserSettings defaultSettings].currency;
            ((NumberCell*)cell).numberUnit = [UserSettings defaultSettings].currency;
        } else {
            
            ((NumberCell*)cell).numberProperty = @"weight";
            ((NumberCell*)cell).numberLabel = [UserSettings defaultSettings].weight;
            ((NumberCell*)cell).numberUnit = [UserSettings defaultSettings].weight;
        }

        ((NumberCell*)cell).coffeeModel = self.coffeeModel;

        return cell;
    }
    
    if(indexPath.section == 5) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"WorksWithCell"];
        ((WorksWithCell*)cell).coffeeModel = self.coffeeModel;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1) {
        self.coffeeModel.type = indexPath.row;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    
    if(indexPath.section == 2) {
        self.coffeeModel.state = indexPath.row;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    
    if(indexPath.section == 3) {
        if(indexPath.row == 0) {
            VenueSearchViewController *vsvc = [[VenueSearchViewController alloc] init];
            [self.navigationController pushViewController:vsvc animated:YES];
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
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.delegate = self;
    
    if(buttonIndex == 0) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else if(buttonIndex == 1) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}


- (void)saveAndClose:(id)sender {
   
    /*
    self.coffeeModel.name = self.nameField.text;
    self.coffeeModel.price = ([self.priceField.text floatValue] * 100);
    self.coffeeModel.weight = [self.weightField.text integerValue];
    self.coffeeModel.worksWith = [NSArray arrayWithArray:self.worksWithActiveArray];
    
    */
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)favoriteSwitchToggled:(id)sender {
    self.coffeeModel.isFavorited = ((UISwitch*)sender).on;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.coffeeImageView.image = info[@"UIImagePickerControllerEditedImage"];
    self.noImageLabel.text = @"";
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
