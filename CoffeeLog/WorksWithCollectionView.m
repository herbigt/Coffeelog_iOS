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
    
    CGFloat paddingTop = self.maxHeight - ((UIImage*)self.iconViews[indexPath.row]).size.height;
    
    UIImageView *iconView = [[UIImageView alloc] initWithImage:self.iconViews[indexPath.row]];
    iconView.frame = CGRectMake(0, paddingTop, iconView.bounds.size.width, iconView.bounds.size.height);
    
    [cell addSubview:iconView];
    
    return cell;
}

@end
