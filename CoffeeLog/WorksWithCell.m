//
//  WorksWithCell.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 19.11.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "WorksWithCell.h"

#import "WorksWithCollectionView.h"

@interface WorksWithCell()

@property (strong, nonatomic) WorksWithCollectionView *wwcv;

@end

@implementation WorksWithCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.wwcv = [[WorksWithCollectionView alloc] initWithFrame:CGRectMake(16, 16, self.bounds.size.width - 16*2, self.bounds.size.height - 16)];
        self.wwcv.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
        self.wwcv.tintColor = UIColorFromRGB(0xc6c7c8);
        
        [self addSubview:self.wwcv];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setCoffeeModel:(CoffeeModel *)coffeeModel {
    _coffeeModel = coffeeModel;
    
    NSMutableArray *active = [NSMutableArray arrayWithArray:coffeeModel.worksWith];
    
    [self.wwcv setTypesArray:[CoffeeModel coffeeWorksWith]];
    [self.wwcv setActiveTypes:active];
}

@end
