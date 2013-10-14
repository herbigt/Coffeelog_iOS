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
    
    for(NSString *type in typesArray) {
        UIImage *iconImage = [UIImage imageNamed:[NSString stringWithFormat:@"type_%@", type]];
        [self.iconViews addObject:iconImage];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.typesArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {    
    return ((UIImage*)self.iconViews[indexPath.row]).size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UIImageView *iconView = [[UIImageView alloc] initWithImage:self.iconViews[indexPath.row]];
    
    [cell addSubview:iconView];
    
    return cell;
}

@end
