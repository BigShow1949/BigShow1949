//
//  SDBaseRefreshView.m
//


#import "SDBaseRefreshView.h"

NSString *const kSDBaseRefreshViewObserveKeyPath = @"contentOffset";

@implementation SDBaseRefreshView

- (void)setScrollView:(UIView<ArtRefreshViewProtocol> *)scrollView
{
    _scrollView = scrollView;
    
    [scrollView addObserver:self forKeyPath:kSDBaseRefreshViewObserveKeyPath options:NSKeyValueObservingOptionNew context:nil];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self.scrollView removeObserver:self forKeyPath:kSDBaseRefreshViewObserveKeyPath];
    }
}

- (void)endRefreshing
{
    self.refreshState = SDWXRefreshViewStateNormal;
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    // 子类实现
}

@end
