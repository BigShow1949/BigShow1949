//
//  YFKeepViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/5/11.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFKeepViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface YFKeepViewController ()
@property(nonatomic,strong)MPMoviePlayerController *moviePlayer;
@property(nonatomic ,strong)NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIView *alpaView;

@property (weak, nonatomic) IBOutlet UIButton *regiset;
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property(nonatomic ,strong)AVAudioSession *avaudioSession;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondViewLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thirdViewLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fourViewLeading;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstLabelWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondLabelWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thridLabelWidth;
@end

@implementation YFKeepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    /**
     *  设置其他音乐软件播放的音乐不被打断
     */
    
    self.avaudioSession = [AVAudioSession sharedInstance];
    NSError *error = nil;
    [self.avaudioSession setCategory:AVAudioSessionCategoryAmbient error:&error];
    
    
    
    NSString *urlStr = [[NSBundle mainBundle]pathForResource:@"1.mp4" ofType:nil];
    
    NSURL *url = [NSURL fileURLWithPath:urlStr];
    
    _moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:url];
    //    _moviePlayer.controlStyle = MPMovieControlStyleDefault;
    [_moviePlayer play];
    [_moviePlayer.view setFrame:self.view.bounds];
    
    [self.view addSubview:_moviePlayer.view];
    _moviePlayer.shouldAutoplay = YES;
    [_moviePlayer setControlStyle:MPMovieControlStyleNone];
    [_moviePlayer setFullscreen:YES];
    
    [_moviePlayer setRepeatMode:MPMovieRepeatModeOne];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackStateChanged)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_moviePlayer];
    
    
    _alpaView.backgroundColor = [UIColor clearColor];
    
    [_moviePlayer.view addSubview:_alpaView];
    
    self.regiset.layer.cornerRadius = 3.0f;
    self.regiset.alpha = 0.4f;
    
    self.login.layer.cornerRadius = 3.0f;
    self.login.alpha = 0.4f;
    
    self.scrollView.bounces = NO;
    
    self.scrollView.pagingEnabled = YES;
    
    self.pageControl.currentPage = 0;
    [self.pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    [self setupTimer];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)playbackStateChanged{
    
    
    //取得目前状态
    MPMoviePlaybackState playbackState = [_moviePlayer playbackState];
    
    //状态类型
    switch (playbackState) {
        case MPMoviePlaybackStateStopped:
            [_moviePlayer play];
            break;
            
        case MPMoviePlaybackStatePlaying:
            NSLog(@"播放中");
            break;
            
        case MPMoviePlaybackStatePaused:
            [_moviePlayer play];
            break;
            
        case MPMoviePlaybackStateInterrupted:
            NSLog(@"播放被中断");
            break;
            
        case MPMoviePlaybackStateSeekingForward:
            NSLog(@"往前快转");
            break;
            
        case MPMoviePlaybackStateSeekingBackward:
            NSLog(@"往后快转");
            break;
            
        default:
            NSLog(@"无法辨识的状态");
            break;
    }
}




-(void)updateViewConstraints{
    
    [super updateViewConstraints];
    
    self.viewWidth.constant = CGRectGetWidth([UIScreen mainScreen].bounds) *4 ;
    self.secondViewLeading.constant = CGRectGetWidth([UIScreen mainScreen].bounds);
    
    self.thirdViewLeading.constant = CGRectGetWidth([UIScreen mainScreen].bounds) *2;
    self.fourViewLeading.constant =CGRectGetWidth([UIScreen mainScreen].bounds) *3;
    self.firstLabelWidth.constant = CGRectGetWidth([UIScreen mainScreen].bounds);
    
    self.secondLabelWidth.constant =CGRectGetWidth([UIScreen mainScreen].bounds);
    self.thridLabelWidth.constant = CGRectGetWidth([UIScreen mainScreen].bounds);
}



//ios以后隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)setupTimer{
    
    self.timer = [NSTimer timerWithTimeInterval:3.0f target:self selector:@selector(timerChanged) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

-(void)pageChanged:(UIPageControl *)pageControl{
    
    CGFloat x = (pageControl.currentPage) * [UIScreen mainScreen].bounds.size.width;
    
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
    
    
}

-(void)timerChanged{
    int page  = (self.pageControl.currentPage +1) %4;
    
    self.pageControl.currentPage = page;
    
    [self pageChanged:self.pageControl];
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    double page = self.scrollView.contentOffset.x / self.scrollView.bounds.size.width;
    self.pageControl.currentPage = page;
    
    if (page== - 1)
    {
        self.pageControl.currentPage = 3;// 序号0 最后1页
    }
    else if (page == 4)
    {
        self.pageControl.currentPage = 0; // 最后+1,循环第1页
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self setupTimer];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
