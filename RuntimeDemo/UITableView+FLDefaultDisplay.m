//
//  UITableView+FLDefaultDisplay.m
//  RuntimeDemo
//
//  Created by fanglin on 2019/6/4.
//  Copyright © 2019 fanglin. All rights reserved.
//

#import "UITableView+FLDefaultDisplay.h"
#import <objc/runtime.h>

const char *FLDefaultView;

@implementation UITableView (FLDefaultDisplay)

+ (void)load{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
        Method originMethod = class_getInstanceMethod(self, @selector(reloadData));
        Method currentMethod = class_getInstanceMethod(self, @selector(fl_reloadData));
        method_exchangeImplementations(originMethod, currentMethod);
//    });
}

- (void)fl_reloadData{
    [self fl_reloadData];
    [self fillDefaultView];
}

- (void)fillDefaultView{
    id<UITableViewDataSource> dataSource = self.dataSource;
    NSInteger section = ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)] ? [dataSource numberOfSectionsInTableView:self] : 1);
    NSInteger rows = 0;
    for (NSInteger i = 0; i < section; i++) {
        rows = [dataSource tableView:self numberOfRowsInSection:section];
    }
    if (!rows) {
        self.flDefaultView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.flDefaultView.backgroundColor = [UIColor blueColor];
        [self addSubview:self.flDefaultView];
    }else {
        self.flDefaultView.hidden = YES;
    }
}

#pragma mark -- setter and getter

- (void)setFlDefaultView:(UIView *)flDefaultView{
    objc_setAssociatedObject(self, &FLDefaultView, flDefaultView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)flDefaultView{
    return objc_getAssociatedObject(self, &FLDefaultView);
}

@end
