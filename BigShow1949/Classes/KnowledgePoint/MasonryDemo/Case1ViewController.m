//
//  Case1ViewController.m
//  MasonryExample
//
//  Created by zorro on 15/5/13.
//  Copyright (c) 2015年 tutuge. All rights reserved.
//

#import "Case1ViewController.h"
#import "Masonry.h"

@interface Case1ViewController ()
@property (strong, nonatomic) UILabel *label1;
@property (strong, nonatomic) UILabel *label2;

@property (weak, nonatomic) IBOutlet UIView *contentView1;
@end

@implementation Case1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initViews];
}

#pragma mark - Actions

- (IBAction)addLabelContent:(UIStepper *)sender {

    switch (sender.tag) {
        case 0:
            _label1.text = [self getLabelContentWithCount:(NSUInteger)sender.value];
            break;

        case 1:
            _label2.text = [self getLabelContentWithCount:(NSUInteger)sender.value];
            break;

        default:
            break;
    }
}

#pragma mark - Private methods

- (void)initViews {
    _label1 = [UILabel new];
    _label1.backgroundColor = [UIColor yellowColor];
    _label1.text = @"label,";

    _label2 = [UILabel new];
    _label2.backgroundColor = [UIColor greenColor];
    _label2.text = @"label,";

    [_contentView1 addSubview:_label1];
    [_contentView1 addSubview:_label2];

    // label1: 位于左上角
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView1.mas_top).with.offset(5);
        make.left.equalTo(_contentView1.mas_left).with.offset(2);

        // 40高度
        make.height.equalTo(@40);
    }];

    // label2: 位于右上角
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        //左边贴着label1
        make.left.equalTo(_label1.mas_right).with.offset(2);

        //上边贴着父view
        make.top.equalTo(_contentView1.mas_top).with.offset(5);

        //右边的间隔保持大于等于2，注意是lessThanOrEqual
        //这里的“lessThanOrEqualTo”放在从左往右的X轴上考虑会更好理解。
        //即：label2的右边界的X坐标值“小于等于”containView的右边界的X坐标值。
        make.right.lessThanOrEqualTo(_contentView1.mas_right).with.offset(-2);

        //只设置高度40
        make.height.equalTo(@40);
    }];

    //设置label1的content hugging 为1000
    [_label1 setContentHuggingPriority:UILayoutPriorityRequired
                               forAxis:UILayoutConstraintAxisHorizontal];

    //设置label1的content compression 为1000
    [_label1 setContentCompressionResistancePriority:UILayoutPriorityRequired
                                             forAxis:UILayoutConstraintAxisHorizontal];

    //设置右边的label2的content hugging 为1000
    [_label2 setContentHuggingPriority:UILayoutPriorityRequired
                               forAxis:UILayoutConstraintAxisHorizontal];

    //设置右边的label2的content compression 为250
    [_label2 setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                                             forAxis:UILayoutConstraintAxisHorizontal];
    
    // Content Hugging Priority代表控件拒绝拉伸的优先级。优先级越高，控件会越不容易被拉伸。
    // Content Compression Resistance Priority代表控件拒绝压缩内置空间的优先级。优先级越高，控件的内置空间会越不容易被压缩。
}

- (NSString *)getLabelContentWithCount:(NSUInteger)count {
    NSMutableString *ret = [NSMutableString new];

    for (NSUInteger i = 0; i <= count; i++) {
        [ret appendString:@"label,"];
    }

    return ret.copy;
}

@end
