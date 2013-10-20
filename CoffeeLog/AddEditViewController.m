//
//  AddEditViewController.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 14.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "AddEditViewController.h"

#import "WorksWithCollectionView.h"

@interface AddEditViewController ()

@property (strong, nonatomic) UIImageView *coffeeImageView;
@property (strong, nonatomic) UILabel *noImageLabel;

@property (strong, nonatomic) NSArray *typesArray;
@property (strong, nonatomic) NSArray *statesArray;
@property (strong, nonatomic) NSArray *worksWithArray;

@property (strong, nonatomic) UITextField *nameField;
@property (strong, nonatomic) UITextField *priceField;
@property (strong, nonatomic) UITextField *weightField;
@property (strong, nonatomic) UITextField *webField;

@end

@implementation AddEditViewController

-(id)initWithCoffeeModel:(CoffeeModel *)coffeeModel {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if(self) {
         _coffeeModel = coffeeModel;
        
        self.typesArray = @[@"Espresso", @"Coffee", @"Blend"];
        self.statesArray = @[@"Grinded", @"Beans (roasted)", @"Beans (unroasted)"];
        self.worksWithArray = @[@"aero", @"filter", @"frenchpress", @"sieb", @"turkish"];
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
    self.noImageLabel.text = @"Tap to add image";
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
    
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(saveAndClose:)];
    add.tintColor = [UIColor whiteColor];
     
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationItem.backBarButtonItem.title = @"Coffee Log";
    
    self.tableView.backgroundColor = UIColorFromRGB(0xffffff);
    
    
    [self.navigationItem setRightBarButtonItem:add];
    
	[self.navigationController setNavigationBarHidden:NO];
    
    // Initialize the form fields
    self.nameField = [[UITextField alloc] init];
    self.nameField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    self.nameField.textColor = UIColorFromRGB(0x8e8e93);
    self.nameField.placeholder = @"Name";
    self.nameField.returnKeyType = UIReturnKeyDone;
    //self.nameField.text = self.coffeeModel.name;
    
    self.priceField = [[UITextField alloc] init];
    self.priceField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    self.priceField.textColor = UIColorFromRGB(0x8e8e93);
    self.priceField.returnKeyType = UIReturnKeyDone;
    self.priceField.placeholder = @"Price";
    
    self.weightField = [[UITextField alloc] init];
    self.weightField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    self.weightField.textColor = UIColorFromRGB(0x8e8e93);
    self.weightField.returnKeyType = UIReturnKeyDone;
    self.weightField.placeholder = @"Weight";

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
        return self.typesArray.count;
    }
    
    if(section == 2) {
        return self.statesArray.count;
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
        return @"Type";
    }
    
    if(section == 2) {
        return @"State";
    }
    
    if(section == 3) {
        return @"Bought at";
    }
    
    if(section == 4) {
        return @"Price & Weight";
    }
    
    if(section == 5) {
        return @"Works with";
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
    CGFloat paddingLeft = 16;
    CGFloat cellHeight = [self tableView:tableView heightForRowAtIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    if(indexPath.section == 0) {
        if(indexPath.row == 0) {
            self.nameField.frame = CGRectMake(paddingLeft, 0, 294, cellHeight);
            [cell addSubview:self.nameField];
        } else if (indexPath.row == 1) {
            UILabel *favLabel = [[UILabel alloc] initWithFrame:CGRectMake(paddingLeft, 0, 250, cellHeight)];
            favLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
            favLabel.textColor = UIColorFromRGB(0x61605e);
            favLabel.text = @"Favorite";
            
            CGFloat switchY = cellHeight/2 - 31/2;
            UISwitch *favSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(255, switchY, 52, 31)];
            
            [cell addSubview:favLabel];
            [cell addSubview:favSwitch];
        }
        
        return cell;
    }
    
    if(indexPath.section == 1) {
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(paddingLeft, 0, 250, cellHeight)];
        typeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        typeLabel.textColor = UIColorFromRGB(0x61605e);
        typeLabel.text = self.typesArray[indexPath.row];
        
        [cell addSubview:typeLabel];
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        return cell;
    }
    
    if(indexPath.section == 2) {
        UILabel *stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(paddingLeft, 0, 250, cellHeight)];
        stateLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        stateLabel.textColor = UIColorFromRGB(0x61605e);
        stateLabel.text = self.statesArray[indexPath.row];
        
        [cell addSubview:stateLabel];
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        return cell;
    }
    
    
    if(indexPath.section == 3) {
        UILabel *boughtLabel = [[UILabel alloc] initWithFrame:CGRectMake(paddingLeft, 0, 250, cellHeight)];
        boughtLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        boughtLabel.textColor = UIColorFromRGB(0x8e8e93);
        [cell addSubview:boughtLabel];

        if(indexPath.row == 0) {
            boughtLabel.text = @"Location";
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            boughtLabel.text = @"Website";
        }
        
        
        return cell;
    }
    
    if(indexPath.section == 4) {
        UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 25, cellHeight)];
        unitLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        unitLabel.textColor = UIColorFromRGB(0x61605e);
        
        if(indexPath.row == 0) {
            self.priceField.frame = CGRectMake(paddingLeft, 0, 60, cellHeight);
            [cell addSubview:self.priceField];
            
            unitLabel.text = @"€";
        } else {
            self.weightField.frame = CGRectMake(paddingLeft, 0, 60, cellHeight);
            [cell addSubview:self.weightField];
            
            unitLabel.text = @"g";
        }
        
        [cell addSubview:unitLabel];
        
        return cell;
    }
    
    if(indexPath.section == 5) {
        WorksWithCollectionView *wwcv = [[WorksWithCollectionView alloc] initWithFrame:CGRectMake(paddingLeft, paddingLeft, self.view.bounds.size.width - paddingLeft*2, cellHeight - paddingLeft)];
        
        wwcv.tintColor = UIColorFromRGB(0xc6c7c8);
        
        [wwcv setTypesArray:self.worksWithArray];
        
        [cell addSubview:wwcv];
    }
    
    return cell;
    
    
}

- (void)openImageActionSheet:(id)sender {
    NSString *destructiveTitle = nil;
    if(self.coffeeImageView.image) {
        destructiveTitle = @"Remove current";
    }
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose image" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:destructiveTitle otherButtonTitles:@"From camera", @"From library", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    
    if(buttonIndex == actionSheet.destructiveButtonIndex) {
        self.coffeeImageView.image = nil;
        self.noImageLabel.text = @"Tap to add image";
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
    NSLog(@"name: %@, price: %@, weight: %@", self.nameField.text, self.priceField.text, self.weightField.text);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"done choosing: %@", info);
    
    self.coffeeImageView.image = info[@"UIImagePickerControllerEditedImage"];
    self.noImageLabel.text = @"";
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
