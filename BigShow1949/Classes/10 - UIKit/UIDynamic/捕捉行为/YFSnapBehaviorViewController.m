//
//
//  捕捉行为:可以让物体迅速冲到某个位置（捕捉位置），捕捉到位置之后会带有一定的震动
//

#import "YFSnapBehaviorViewController.h"
@interface YFSnapBehaviorViewController()

@property(nonatomic,strong)UIDynamicAnimator *animator;
@property (nonatomic, strong) UIButton *blueView;

@end


@implementation YFSnapBehaviorViewController

-(void)viewDidLoad {

    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *blueView = [[UIButton alloc] init];
    blueView.frame = CGRectMake(100, 100, 100, 100);
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    self.blueView = blueView;
}


-(UIDynamicAnimator *)animator
{
    if (_animator==nil) {
        //创建物理仿真器，设置仿真范围，ReferenceView为参照视图
        _animator=[[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return _animator;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //获取一个触摸点
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:touch.view];
    
    //1.创建捕捉行为
    //需要传入两个参数：一个物理仿真元素，一个捕捉点
    UISnapBehavior *snap=[[UISnapBehavior alloc]initWithItem:self.blueView snapToPoint:point];
    //设置防震系数（0~1，数值越大，震动的幅度越小）
    snap.damping=arc4random_uniform(10)/10.0;
    
    //2.执行捕捉行为
    //注意：这个控件只能用在一个仿真行为上，如果要拥有持续的仿真行为，那么需要把之前的所有仿真行为删除
    //删除之前的所有仿真行为
    [self.animator removeAllBehaviors];
    [self.animator addBehavior:snap];
}

@end
