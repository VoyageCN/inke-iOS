//
//  VCPlayerViewController.m
//  inke-iOS
//
//  Created by VoyageCN on 2016/11/10.
//  Copyright © 2016年 VoyageCN. All rights reserved.
//

#import "VCPlayerViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface VCPlayerViewController ()

@property (atomic, retain) id<IJKMediaPlayback> player;

@property (nonatomic, strong) UIImageView *blurImageView;

@property (nonatomic, strong) UIButton *closeButton;

//@property (nonatomic, strong)

@end

@implementation VCPlayerViewController

- (UIButton *)closeButton {
    
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_closeButton setImage:[UIImage imageNamed:@"mg_room_btn_guan_h"] forState:(UIControlStateNormal)];
        [_closeButton sizeToFit];
        _closeButton.frame = CGRectMake(SCREEN_WIDTH - _closeButton.width - 10, SCREEN_HEIGHT - _closeButton.height - 10, _closeButton.width, _closeButton.height);
        [_closeButton addTarget:self action:@selector(closeAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _closeButton;
}

- (void)closeAction:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    // 注册直播需要的通知
    [self installMovieNotificationObservers];
    
    // 准备播放
    [self.player prepareToPlay];
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:self.closeButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initPlayer];
    
    [self initUI];
    
    [self addChildVC];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    // 关闭直播
    [self.player shutdown];
    [self removeMovieNotificationObservers];
    
    [self.closeButton removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initPlayer {
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    
    IJKFFMoviePlayerController *player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:self.live.stream_addr withOptions:options];
    self.player = player;
    self.player.view.frame = self.view.bounds;
    [self.player setShouldAutoplay:YES];
    [self.view addSubview:self.player.view];
}

- (void)initUI {
    
    
}

- (void)addChildVC {
    
//    self.view addSubview:

}

- (void)loadStateDidChange:(NSNotification*)notification
{
    //    MPMovieLoadStateUnknown        = 0,
    //    MPMovieLoadStatePlayable       = 1 << 0,
    //    MPMovieLoadStatePlaythroughOK  = 1 << 1, // Playback will be automatically started in this state when shouldAutoplay is YES
    //    MPMovieLoadStateStalled        = 1 << 2, // Playback will be automatically paused in this state, if started
    
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStatePlaythroughOK: %d\n", (int)loadState);
    } else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackDidFinish:(NSNotification*)notification
{
    //    MPMovieFinishReasonPlaybackEnded,
    //    MPMovieFinishReasonPlaybackError,
    //    MPMovieFinishReasonUserExited
    int reason = [[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    
    switch (reason)
    {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification
{
    NSLog(@"mediaIsPreparedToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification
{
    //    MPMoviePlaybackStateStopped,
    //    MPMoviePlaybackStatePlaying,
    //    MPMoviePlaybackStatePaused,
    //    MPMoviePlaybackStateInterrupted,
    //    MPMoviePlaybackStateSeekingForward,
    //    MPMoviePlaybackStateSeekingBackward
    
    switch (_player.playbackState)
    {
        case IJKMPMoviePlaybackStateStopped: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePlaying: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePaused: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateInterrupted: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
}


#pragma mark Install Movie Notifications

/* Register observers for the various movie object notifications. */
- (void)installMovieNotificationObservers {
    
    // 监听网络环境，监听缓冲方法
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    
    // 监听完成回调
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    // 监听用户主动操作
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
}

#pragma mark Remove Movie Notification Handlers

/* Remove the movie notification observers from the movie object. */
- (void)removeMovieNotificationObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                                  object:_player];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                                  object:_player];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                  object:_player];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:_player];
}











@end
