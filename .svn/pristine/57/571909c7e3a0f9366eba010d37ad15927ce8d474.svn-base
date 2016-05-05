//
//  Case4ViewController.m
//  MasonryExample
//
//  Created by zorro on 15/7/31.
//  Copyright (c) 2015年 tutuge. All rights reserved.
//

#import "Case4ViewController.h"
#import "Case4Cell.h"
#import "Case4DataEntity.h"

// 注释掉下面的宏定义，就是用“传统”的模板Cell计算高度
//#define IOS_8_NEW_FEATURE_SELF_SIZING

@interface Case4ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Case4Cell *templateCell;

@property (nonatomic, strong) NSArray *data;

@end

@implementation Case4ViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 80.0f;

#ifdef IOS_8_NEW_FEATURE_SELF_SIZING
    // iOS 8 的Self-sizing特性
    if ([UIDevice currentDevice].systemVersion.integerValue > 7) {
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
#endif

    // 注册Cell
    [_tableView registerClass:[Case4Cell class] forCellReuseIdentifier:NSStringFromClass([Case4Cell class])];

    [self generateData];

    [_tableView reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

#ifdef IOS_8_NEW_FEATURE_SELF_SIZING
    // iOS 8 的Self-sizing特性
    return UITableViewAutomaticDimension;
#else

    if (!_templateCell) {
        _templateCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([Case4Cell class])];
        _templateCell.tag = -1000; // For debug dealloc
    }

    // 获取对应的数据
    Case4DataEntity *dataEntity = _data[(NSUInteger) indexPath.row];

    // 判断高度是否已经计算过
    if (dataEntity.cellHeight <= 0) {
        // 填充数据
        [_templateCell setupData:dataEntity];
        // 根据当前数据，计算Cell的高度，注意+1
        dataEntity.cellHeight = [_templateCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 0.5f;
        NSLog(@"Calculate: %ld, height: %g", (long) indexPath.row, dataEntity.cellHeight);
    } else {
        NSLog(@"Get cache: %ld, height: %g", (long) indexPath.row, dataEntity.cellHeight);
    }

    return dataEntity.cellHeight;
#endif
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Case4Cell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([Case4Cell class]) forIndexPath:indexPath];
    [cell setupData:_data[(NSUInteger) indexPath.row]];
    return cell;
}

#pragma mark - Private methods

// 生成数据
- (void)generateData {
    NSMutableArray *tmpData = [NSMutableArray new];

    for (int i = 0; i < 20; i++) {
        Case4DataEntity *dataEntity = [Case4DataEntity new];
        dataEntity.avatar = [UIImage imageNamed:[NSString stringWithFormat:@"bluefaces_%d", (i % 4) + 1]];
        dataEntity.title = [NSString stringWithFormat:@"Title: %d", i];
        dataEntity.content = [[self class] getText:@"content-" withRepeat:i * 2 + 1];
        [tmpData addObject:dataEntity];
    }

    _data = tmpData;
}


// 重复text字符串repeat次
+ (NSString *)getText:(NSString *)text withRepeat:(int)repeat {
    NSMutableString *tmpText = [NSMutableString new];
    
    for (int i = 0; i < repeat; i++) {
        [tmpText appendString:text];
    }
    
    return tmpText;
}

@end
