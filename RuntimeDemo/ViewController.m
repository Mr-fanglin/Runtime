//
//  ViewController.m
//  RuntimeDemo
//
//  Created by fanglin on 2019/6/4.
//  Copyright © 2019 fanglin. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak)IBOutlet UITableView *tableView;

@property (nonatomic, strong)NSArray *dataArray;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataArray = @[];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"custom"];
    [_tableView reloadData];
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"custom"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

@end
