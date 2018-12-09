//
//  YFToDoViewController.m
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFToDoViewController.h"

@interface YFToDoViewController ()

@end

@implementation YFToDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.presenter updateView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:@"test"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"row = %ld", (long)indexPath.row];
    return cell;
}

#pragma mark - YFToDoViewControllerDelegate
- (void)showNoContentMessage {
    
}

- (void)showUpcomingDisplayData:(VTDUpcomingDisplayData *)data {
    
}

- (void)reloadEntries {
    
}

@end
