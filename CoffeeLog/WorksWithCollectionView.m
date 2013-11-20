//
//  WorksWithCollectionView.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 14.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "WorksWithCollectionView.h"
#import "CoffeeModel.h"

@interface WorksWithCollectionView()

@property (strong, nonatomic) NSMutableArray *iconViews;
@property (strong, nonatomic) NSMutableArray *activeIconViews;

@property (nonatomic) CGFloat maxHeight;

@property (strong, nonatomic) UIColor *activeTintColor;
@property (strong, nonatomic) UIColor *inactiveTintColor;

@end

@implementation WorksWithCollectionView

- (id)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 25;
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
        
        self.scrollEnabled = NO;
        self.isEditable = YES;
        
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

        self.activeTypes = [NSMutableArray array];
    }
    return self;
}

- (void)setTypesArray:(NSArray *)typesArray {
    _typesArray = typesArray;
    
    self.iconViews = [NSMutableArray array];
    self.activeIconViews = [NSMutableArray array];
    
    self.maxHeight = 0;
    for(NSNumber *type in typesArray) {
        NSString *label = [CoffeeModel labelForWorksWith:[type integerValue]];
        
        UIImage *iconImage = [UIImage imageNamed:[NSString stringWithFormat:@"type_%@", label]];
        [self.iconViews addObject:iconImage];
        
        UIImage *activeIconImage = [UIImage imageNamed:[NSString stringWithFormat:@"type_%@_active", label]];
        [self.activeIconViews addObject:activeIconImage];
        
        if(iconImage.size.height > self.maxHeight) {
            self.maxHeight = iconImage.size.height;
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.typesArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {    
    return CGSizeMake(((UIImage*)self.iconViews[indexPath.row]).size.width, self.maxHeight);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UIImageView *iconView = (UIImageView*)[cell viewWithTag:100];
    if(!iconView) {
        iconView = [[UIImageView alloc] init];
        iconView.tag = 100;
        
        [cell addSubview:iconView];
    }
    
    
    NSString *currentType = self.typesArray[indexPath.row];
    UIImage *icon = [self.activeTypes containsObject:currentType] ? (UIImage*)self.activeIconViews[indexPath.row] : (UIImage*)self.iconViews[indexPath.row];
    
    CGFloat paddingTop = self.maxHeight - icon.size.height;
    
    iconView.image = icon;
    iconView.frame = CGRectMake(0, paddingTop, iconView.image.size.width, iconView.image.size.height);

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if(!self.isEditable) {
        return;
    }
    
    NSString *currentType = self.typesArray[indexPath.row];
    if([self.activeTypes containsObject:currentType]) {
        [self.activeTypes removeObject:currentType];
    } else {
        [self.activeTypes addObject:currentType];
    }
    
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

@end
