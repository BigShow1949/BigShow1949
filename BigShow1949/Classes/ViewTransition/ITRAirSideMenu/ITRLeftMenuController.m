//
//  LeftMenuController.m
//  ITRAirSideMenu
//
//  Created by kirthi on 12/08/15.
//  Copyright (c) 2015 kirthi. All rights reserved.
//

#import "ITRLeftMenuController.h"
#import "ITRFirstViewController.h"
#import "ITRSecondViewController.h"
#import "AppDelegate.h"

@interface ITRLeftMenuController ()
{
    NSIndexPath *selectedIndexPath;
}
//@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ITRLeftMenuController


+ (instancetype)controller {
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ITRLeftMenuController class])];
    
    ITRLeftMenuController *leftVC = [[ITRLeftMenuController alloc] init];
    return leftVC;
    
}

#pragma view lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    ITRAirSideMenu *itrSideMenu = ((AppDelegate *)[UIApplication sharedApplication].delegate).itrAirSideMenu;
//    //update content view controller with setContentViewController
//    [itrSideMenu hideMenuViewController];
//    selectedIndexPath = indexPath;
    
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    NSArray *titles = @[@"Menu1", @"Menu2", @"Menu3", @"Menu4", @"Menu5"];
    cell.textLabel.text = titles[indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark ITRAirSideMenu Delegate

- (void)sideMenu:(ITRAirSideMenu *)sideMenu didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer {
    
    NSLog(@"didRecognizePanGesture");
}

- (void)sideMenu:(ITRAirSideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController {
    
    NSLog(@"willShowMenuViewController: %@ isMenuVisible <%d>", NSStringFromClass([menuViewController class]), (int)sideMenu.isLeftMenuVisible );
}

- (void)sideMenu:(ITRAirSideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController {
    
    NSLog(@"didShowMenuViewController: %@ isMenuVisible <%d>", NSStringFromClass([menuViewController class]), (int)sideMenu.isLeftMenuVisible );
}

- (void)sideMenu:(ITRAirSideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController {
    
    NSLog(@"willHideMenuViewController: %@ isMenuVisible <%d>", NSStringFromClass([menuViewController class]), (int)sideMenu.isLeftMenuVisible );
}

- (void)sideMenu:(ITRAirSideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController{
    
    NSLog(@"didHideMenuViewController: %@ isMenuVisible <%d>", NSStringFromClass([menuViewController class]), (int)sideMenu.isLeftMenuVisible );
    
    if (selectedIndexPath.row % 2 == 0) {
        [sideMenu setContentViewController:[[UINavigationController alloc] initWithRootViewController:[ITRFirstViewController controller]]];
    }else{
        
        [sideMenu setContentViewController:[[UINavigationController alloc] initWithRootViewController:[ITRSecondViewController controller]]];
    }
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com