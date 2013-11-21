//
//  WorksWithCollectionView.h
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 14.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WorksWithCollectionView;

@protocol WorksWithCollectionViewDelegate

- (void)worksWithCollectionViewUpdatedChoice:(WorksWithCollectionView*)wwcv;

@end

@interface WorksWithCollectionView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSArray *typesArray;
@property (strong, nonatomic) NSMutableArray *activeTypes;
@property (nonatomic) BOOL isEditable;

@property (weak, nonatomic) id<WorksWithCollectionViewDelegate> worksWithDelegate;

@end

