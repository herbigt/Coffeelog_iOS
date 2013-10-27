//
//  WorksWithCollectionView.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 14.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "WorksWithCollectionView.h"

@interface WorksWithCollectionView()

@property (strong, nonatomic) NSMutableArray *iconViews;
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
        
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        self.activeTintColor = UIColorFromRGB(0x605f5e);
        self.inactiveTintColor = UIColorFromRGB(0xc6c7c8);
        
        self.activeTypes = [NSMutableArray array];
    }
    return self;
}

- (void)setTypesArray:(NSArray *)typesArray {
    _typesArray = typesArray;
    
    self.iconViews = [NSMutableArray array];
    
    self.maxHeight = 0;
    for(NSString *type in typesArray) {
        UIImage *iconImage = [[UIImage imageNamed:[NSString stringWithFormat:@"type_%@", type]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [self.iconViews addObject:iconImage];
        
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
    
    CGFloat paddingTop = self.maxHeight - ((UIImage*)self.iconViews[indexPath.row]).size.height;
    NSString *currentType = self.typesArray[indexPath.row];
    
    iconView.image = self.iconViews[indexPath.row];
    iconView.frame = CGRectMake(0, paddingTop, iconView.image.size.width, iconView.image.size.height);
    iconView.tintColor = [self.activeTypes containsObject:currentType] ? self.activeTintColor : self.inactiveTintColor;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if(![self.activeTypes isKindOfClass:[NSMutableArray class]]) {
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
