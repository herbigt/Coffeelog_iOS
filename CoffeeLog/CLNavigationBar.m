//
//  UINavigationBar+CustomHeight.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 02.02.14.
//  Copyright (c) 2014 CoffeeLog. All rights reserved.
//

#import "CLNavigationBar.h"

@implementation CLNavigationBar

- (CGSize)sizeThatFits:(CGSize)size {
    
    CGSize newSize = CGSizeMake(self.frame.size.width, 88);
    return newSize;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    int i = 0;
    for (UIView *view in self.subviews) {
        NSLog(@"%i. %@", i, [view description]);
        
        if([view isKindOfClass:[UIView class]] && view.tag == 100) {
            view.frame = CGRectMake(0, 44, self.frame.size.width, 44);
        }
        
        if([view isKindOfClass:[UILabel class]] && view.tag == 200) {
            view.frame = CGRectMake(0, 2, self.bounds.size.width, view.bounds.size.height);
        }
        
        NSString *className = NSStringFromClass([view class]);
        
        if([className isEqualToString:@"UINavigationButton"]) {
            view.frame = CGRectMake(view.frame.origin.x, 6, view.bounds.size.width, view.bounds.size.height);
        }
        
        if([view isKindOfClass:[UISearchBar class]] && view.tag == 300) {
            view.frame = CGRectMake(view.frame.origin.x, 10, view.bounds.size.width, 20);
            continue;
        }
        
        if([view isKindOfClass:[UISearchBar class]] && view.tag == 400) {
            view.frame = CGRectMake(self.bounds.size.width / 2 - view.bounds.size.width / 2, 20, view.bounds.size.width, view.bounds.size.height);
            continue;
        }
    }
}

@end
