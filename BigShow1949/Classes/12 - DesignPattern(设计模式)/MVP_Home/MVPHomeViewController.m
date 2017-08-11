//
//  MVPHomeViewController.m
//  BigShow1949
//
//  Created by apple on 17/8/11.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import "MVPHomeViewController.h"
#import "HomePresenter.h"
#import "HomeViewProtocol.h"

@interface MVPHomeViewController ()<HomeViewProtocol>
@property (nonatomic,strong)HomePresenter *homePresenter;
@end

@implementation MVPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupData];
}
- (void)setupData{
    /*
     http://www.jianshu.com/p/abea207c23e7#
     */
    _homePresenter = [[HomePresenter alloc] initWithView:self];
    [_homePresenter getMovieListWithUrlString:@"https://api.douban.com/v2/book/search?count=20&q=iOS"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - HomeViewProtocol

- (void)onGetMovieListSuccess:(HomeModel *)homeModel{
    
    UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:@"result" message:@"request success" preferredStyle:UIAlertControllerStyleActionSheet];
    [self presentViewController:alertCtl animated:YES completion:nil];
}

- (void)onGetMovieListFail:(NSInteger)errorCode des:(NSString *)des{
    UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:@"result" message:@"request fail" preferredStyle:UIAlertControllerStyleActionSheet];
    [self presentViewController:alertCtl animated:YES completion:nil];
}
@end
