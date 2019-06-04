//
//  UITableView+FLDefaultDisplay.h
//  RuntimeDemo
//
//  Created by fanglin on 2019/6/4.
//  Copyright © 2019 fanglin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (FLDefaultDisplay)

@property(strong, nonatomic) UIView *flDefaultView;

-(void)fl_reloadData;

@end

NS_ASSUME_NONNULL_END
