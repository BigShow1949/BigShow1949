//
//  SDBaseRefreshView.h
//


#import <UIKit/UIKit.h>

@protocol ArtRefreshViewProtocol <NSObject>

@property (nonatomic, assign) CGPoint contentOffset;
@property (nonatomic, assign) BOOL isDragging;

@end

UIKIT_EXTERN NSString *const kSDBaseRefreshViewObserveKeyPath;

typedef enum {
    SDWXRefreshViewStateNormal,
    SDWXRefreshViewStateWillRefresh,
    SDWXRefreshViewStateRefreshing,
} SDWXRefreshViewState;

@interface SDBaseRefreshView : UIView

// 用strong 是为了移除监听时scrollView 不为空，注意循环引用。
@property (nonatomic, strong) UIView<ArtRefreshViewProtocol> *scrollView;

- (void)endRefreshing;

@property (nonatomic, assign) UIEdgeInsets scrollViewOriginalInsets;
@property (nonatomic, assign) SDWXRefreshViewState refreshState;

@end
