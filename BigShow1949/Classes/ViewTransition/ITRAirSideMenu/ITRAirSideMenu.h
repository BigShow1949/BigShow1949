

#import <UIKit/UIKit.h>

@protocol ITRAirSideMenuDelegate;

@interface ITRAirSideMenu : UIViewController <UIGestureRecognizerDelegate>

@property (strong, readwrite, nonatomic) UIViewController *contentViewController;
@property (strong, readwrite, nonatomic) UIViewController *leftMenuViewController;

@property (weak, readwrite, nonatomic) id<ITRAirSideMenuDelegate> delegate;

@property (assign, readonly, nonatomic, getter=isLeftMenuVisible) BOOL isLeftMenuVisible;
@property (assign, readwrite, nonatomic) NSTimeInterval animationDuration;
@property (strong, readwrite, nonatomic) UIImage *backgroundImage;
@property (assign, readwrite, nonatomic) BOOL panGestureEnabled;
@property (assign, readwrite, nonatomic) BOOL panFromEdge;
@property (assign, readwrite, nonatomic) NSUInteger panMinimumOpenThreshold;
@property (assign, readwrite, nonatomic) IBInspectable BOOL interactivePopGestureRecognizerEnabled;

@property (assign, readwrite, nonatomic) IBInspectable BOOL contentViewShadowEnabled;
@property (strong, readwrite, nonatomic) IBInspectable UIColor *contentViewShadowColor;
@property (assign, readwrite, nonatomic) IBInspectable CGSize contentViewShadowOffset;
@property (assign, readwrite, nonatomic) IBInspectable CGFloat contentViewShadowOpacity;
@property (assign, readwrite, nonatomic) IBInspectable CGFloat contentViewShadowRadius;
@property (assign, readwrite, nonatomic) IBInspectable CGFloat contentViewFadeOutAlpha;

@property (assign, readwrite, nonatomic) IBInspectable CGFloat contentViewScaleValue;
@property (assign, readwrite, nonatomic) IBInspectable CGFloat contentViewRotatingAngle;
@property (assign, readwrite, nonatomic) IBInspectable CGFloat contentViewTranslateX;

@property (assign, readwrite, nonatomic) IBInspectable CGFloat menuViewRotatingAngle;
@property (assign, readwrite, nonatomic) IBInspectable CGFloat menuViewTranslateX;


- (id)initWithContentViewController:(UIViewController *)contentViewController
             leftMenuViewController:(UIViewController *)leftMenuViewController;
- (void)presentLeftMenuViewController;
- (void)hideMenuViewController;
- (void)setContentViewController:(UIViewController *)contentViewController animated:(BOOL)animated;

@end

@protocol ITRAirSideMenuDelegate <NSObject>

@optional
- (void)sideMenu:(ITRAirSideMenu *)sideMenu didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer;
- (void)sideMenu:(ITRAirSideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController;
- (void)sideMenu:(ITRAirSideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController;
- (void)sideMenu:(ITRAirSideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController;
- (void)sideMenu:(ITRAirSideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com