//
//  ISStylePlayerCell.m
//  M-Cut
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "ISStylePlayerCell.h"
#import "OssFileDown.h"
#import <MBProgressHUD.h>
#import <UIImageView+WebCache.h>
#import <AVFoundation/AVFoundation.h>
#import "CustomeClass.h"

@interface ISStylePlayerCell ()<OssFileDownDelegate>
@property (nonatomic, strong) MBProgressHUD * HUD;
/** 视频是否正在播放*/
@property (nonatomic, assign) BOOL isPlay;
/** 播放界面手势*/
@property (nonatomic, strong) UITapGestureRecognizer * playGesture;
/** 开始播放时间*/
@property (nonatomic, copy) NSString * startTime;
/** 当前播放url*/
@property (nonatomic, copy) NSString * filePath;
/** 下载次数*/
@property (nonatomic, assign) NSUInteger downloadTimes;
@end

@implementation ISStylePlayerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self isHiddenVideoImage];
}

- (void)isHiddenVideoImage{
    
    if (!self.myStyle) {
        self.thumbImage.hidden = YES;
        self.playButton.hidden = YES;
    }
}

- (void)showVideoImageWithStyle:(ISStyleDetailFrame *)myStyle{
    self.myStyle = myStyle;
    [self setPlayerCellWithStyle];
}

- (void)showVideoImageWithUrl:(NSString *)videoUrl{
    [self setPlayerCellWithVideoUrl:videoUrl];
}

- (void)movieDidFinish2:(NSNotification *)noti{
    [self startPlay:nil Local:self.filePath];
}

- (void)setPlayerCellWithVideoUrl:(NSString *)videoUrl{
    self.thumbImage.hidden = YES;
    self.playButton.hidden = YES;
    self.downloadTimes = 0;
    
    //初始化播放器
    self.mpMovierPlayerVc = [[MPMoviePlayerViewController alloc] initWithContentURL:nil];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:MPMoviePlayerPlaybackDidFinishNotification object:[self.mpMovierPlayerVc moviePlayer] userInfo:nil]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieDidFinish2:) name:MPMoviePlayerPlaybackDidFinishNotification object:[self.mpMovierPlayerVc moviePlayer]];
    [self.mpMovierPlayerVc.view setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    [self.contentView addSubview:self.mpMovierPlayerVc.view];
    [self.mpMovierPlayerVc moviePlayer].controlStyle = MPMovieControlStyleNone;
    [self.mpMovierPlayerVc moviePlayer].scalingMode = MPMovieScalingModeAspectFit;
    
    
    self.isPlay = NO;
    
    NSString *filename = self.myStyle.styleDetail.videoUrl;
    filename = [filename lastPathComponent];
    NSString *filepath = [self dirDoc];
    filepath = [filepath stringByAppendingFormat:@"/%@",filename];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    self.filePath = filepath;
    if([fileManager fileExistsAtPath:filepath]){
        [self startPlay:nil Local:filepath];
    }
    else{
        [self downVideoWithPath:filepath Url:videoUrl];
    }

}

- (void)hiddenVideoImage{
    self.myStyle = nil;
    [self isHiddenVideoImage];
}

/** 停止播放*/
- (void)pauseVideo:(NSNotification *)noti{
    [[self.mpMovierPlayerVc moviePlayer] pause];
    self.mpMovierPlayerVc = nil;
}

/** 设置缩略图和url*/
- (void)setPlayerCellWithStyle{
    if (self.thumbImage.hidden) {
        self.thumbImage.hidden = NO;
        self.playButton.hidden = NO;
        [self.HUD setHidden:YES];
    }
    
    self.downloadTimes = 0;
    
    //注册接受视频停止的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pauseVideo:) name:@"pauseVideo" object:nil];
    
    //初始化播放器
    self.mpMovierPlayerVc = [[MPMoviePlayerViewController alloc] initWithContentURL:nil];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:MPMoviePlayerPlaybackDidFinishNotification object:[self.mpMovierPlayerVc moviePlayer] userInfo:nil]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:[self.mpMovierPlayerVc moviePlayer]];
    [self.mpMovierPlayerVc.view setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    [self.contentView addSubview:self.mpMovierPlayerVc.view];
    [self.mpMovierPlayerVc moviePlayer].controlStyle = MPMovieControlStyleNone;
    [self.mpMovierPlayerVc moviePlayer].scalingMode = MPMovieScalingModeAspectFit;
    
    //缩略图
    [self.thumbImage sd_setImageWithURL:[NSURL URLWithString:[self.myStyle.styleDetail.thumbnail stringByReplacingOccurrencesOfString:@"thumbnail.jpg" withString:@"thumbnail720.jpg"]] placeholderImage:DEFAULTVIDEOTHUMAIL options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    [self.contentView insertSubview:self.thumbImage aboveSubview:self.mpMovierPlayerVc.view];
    
    //初始化播放按钮
    self.thumbImage.userInteractionEnabled = YES;
    self.playButton.userInteractionEnabled = YES;
    [self.playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [self.playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView insertSubview:self.playButton aboveSubview:self.thumbImage];
    
    self.isPlay = NO;
}

/** 播放手势方法*/
- (void)playGestureAction:(UITapGestureRecognizer *)tap{
    if (self.playButton.hidden == NO) {
        self.playButton.hidden = YES;
    }else{
        self.playButton.hidden = NO;
    }
}

/** 播放按钮点击方法*/
- (void)playButtonAction:(UIButton *)button{
    self.playButton.selected = !self.playButton.selected;
        //添加播放界面手势
        self.playGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playGestureAction:)];
        self.playGesture.numberOfTapsRequired = 1;
        [self.mpMovierPlayerVc.view addGestureRecognizer:self.playGesture];
    
    NSString *filename = self.myStyle.styleDetail.videoUrl;
    filename = [filename lastPathComponent];
    NSString *filepath = [self dirDoc];
    filepath = [filepath stringByAppendingFormat:@"/%@",filename];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    self.filePath = filepath;
    if([fileManager fileExistsAtPath:filepath]){
        [self startPlay:button Local:filepath];
    }
    else{
        [self downVideoWithPath:filepath];
    }
}

- (void)downVideoWithPath:(NSString *)filePath Url:(NSString *)downloadUrl{
    if (self.HUD) {
        [self.HUD hide:YES];
        self.HUD = nil;
    }
    self.HUD = [[MBProgressHUD alloc] initWithView:self.mpMovierPlayerVc.view];
    self.HUD.mode = MBProgressHUDModeAnnularDeterminate;
    self.HUD.labelText = @"加载...";
    self.HUD.labelColor = [UIColor colorWithRed:255/255.0f green:78/255.0f blue:77/255.0f alpha:1];
    self.HUD.labelFont = [UIFont boldSystemFontOfSize:13];
    [self.thumbImage insertSubview:self.HUD aboveSubview:self.playButton];
    self.HUD.dimBackground = NO;
    self.HUD.color = [UIColor clearColor];
    self.HUD.activityIndicatorColor = [UIColor colorWithRed:255/255.0f green:78/255.0f blue:77/255.0f alpha:1];
    [self.HUD show:YES];
    [OssFileDown Singleton].delegate = self;
    [[OssFileDown Singleton] SimpleDown:downloadUrl EXt:@"mp4" LocalFile:filePath];
}

- (void)downVideoWithPath:(NSString *)filepath{
    [self.playButton setImage:nil forState:UIControlStateNormal];
    if (self.HUD) {
        [self.HUD hide:YES];
        self.HUD = nil;
    }
    self.HUD = [[MBProgressHUD alloc] initWithView:self.mpMovierPlayerVc.view];
    self.HUD.mode = MBProgressHUDModeAnnularDeterminate;
    self.HUD.labelText = @"加载...";
    self.HUD.labelColor = [UIColor colorWithRed:255/255.0f green:78/255.0f blue:77/255.0f alpha:1];
    self.HUD.labelFont = [UIFont boldSystemFontOfSize:13];
    [self.thumbImage insertSubview:self.HUD aboveSubview:self.playButton];
    self.HUD.dimBackground = NO;
    self.HUD.color = [UIColor clearColor];
    self.HUD.activityIndicatorColor = [UIColor colorWithRed:255/255.0f green:78/255.0f blue:77/255.0f alpha:1];
    [self.HUD show:YES];
    [OssFileDown Singleton].delegate = self;
    [[OssFileDown Singleton] SimpleDown:self.myStyle.styleDetail.videoUrl EXt:@"mp4" LocalFile:filepath];
}

/** 获取Documents目录*/
-(NSString *)dirDoc{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

- (NSString *)getTimeNow
{
    NSString* date;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    date = [formatter stringFromDate:[NSDate date]];
    NSString * timeNow = [[NSString alloc] initWithFormat:@"%@", date];
    NSLog(@"%@", timeNow);
    return timeNow;
}

+(int)compareOneDay:(NSString *)oneDayStr withAnotherDay:(NSString *)anotherDayStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
}

/** 开始播放*/
-(void)startPlay:(UIButton *)button Local:(NSString*)playurl{
    NSLog(@"开始播放时间%@", [self getTimeNow]);
    self.startTime = [self getTimeNow];
    
    
    self.isPlay = YES;
    self.thumbImage.hidden = YES;
    NSURL* url = [NSURL fileURLWithPath:playurl];
    [self.mpMovierPlayerVc moviePlayer].contentURL = url;
    [[self.mpMovierPlayerVc moviePlayer] play];
    self.playButton.hidden = YES;
    button.selected = !button.selected;
}

/**  当前下载百分比 */
- (void)OssFileDown:(OssFileDown *)pointdownself Process:(float)download{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.HUD.progress = download;
        NSLog(@"download--------%f", download);
    });
    
}
/**  下载完成/下载失败 */
- (void)OssFileDown:(OssFileDown *)pointdownself Status:(BOOL)downsuccess Fileinfo:(NSString *)filepath{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (downsuccess) {
            DEBUGSUCCESSLOG(@"下载成功")
            [self.HUD hide:YES];
            self.HUD = nil;
            [self startPlay:nil Local:filepath];
        }
        else{
            DEBUGLOG(filepath)
            [self againDownloadWithPath:self.filePath];
        }
    });
}

- (void)againDownloadWithPath:(NSString *)filepath{
    self.downloadTimes++;
    if (self.downloadTimes > 6) {
        [CustomeClass showMessage:@"该模板已下架或暂不能使用！" ShowTime:3];
        return;
    }
    [[NSFileManager defaultManager] removeItemAtPath:filepath error:nil];
    [self downVideoWithPath:filepath];
}

/** 通知方法(播放完成)*/
-(void)movieDidFinish:(NSNotification*)notification{
    [self.mpMovierPlayerVc moviePlayer].contentURL = nil;
    self.thumbImage.hidden = NO;
    self.playButton.hidden = NO;
    [self.playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [[self.mpMovierPlayerVc moviePlayer] stop];
    NSLog(@"播放完成时间%@", [self getTimeNow]);
    if ([ISStylePlayerCell compareOneDay:self.startTime withAnotherDay:[self getTimeNow]] == 0) {
        [self againDownloadWithPath:self.filePath];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
