//
//  ISStyleDetailCell.m
//  M-Cut
//
//  Created by 李亚飞 on 15/11/26.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "ISStyleDetailCell.h"
#import "UIImageView+WebCache.h"
// 视频播放器
//#import "NGMoviePlayer.h"
//#import "NGMoviePlayerControlView.h"
#import "OssFileDown.h"
#import "MBProgressHUD.h"

#define Margin (12.0 / 375) * ISScreen_Width

#pragma mark ----- ISStyleDetail 数据模型
@implementation ISStyleDetail

@end


#pragma mark ----- ISStyleDetail 尺寸模型
@implementation ISStyleDetailFrame

- (void)setStyleDetail:(ISStyleDetail *)styleDetail {
    _styleDetail = styleDetail;
    
    // 图片
    CGFloat iconX = Margin;
    CGFloat iconY = Margin;
//    CGFloat iconRatio = 27.0 / 27;
//    CGFloat iconW = 27.0 / 375 * ISScreen_Width;
//    CGFloat iconH = iconW * iconRatio;
//    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    _iconF = CGRectMake(0, 0, ISScreen_Width - 12, 666);
    
    // 标题
    CGFloat titleX = CGRectGetMaxX(_iconF) + Margin;
    CGFloat titleY = iconY;
    CGSize titleSize = [styleDetail.title sizeWithWidth:MAXFLOAT font:ISFont_15];
    _titleF = (CGRect){{titleX, titleY}, titleSize};
    
    // 查看次数
    CGFloat visitX = titleX;
    CGFloat visitY = CGRectGetMaxY(_titleF) + 4.0 / 667 * ISScreen_Height;
    NSString *visitCount = [NSString stringWithFormat:@"%@次查看", styleDetail.visitCount];
    CGSize visitSize = [visitCount sizeWithWidth:MAXFLOAT font:ISFont_12];
    _visitF = (CGRect){{visitX, visitY}, visitSize};
    
    // 选择按钮
    CGFloat maxVisitF = CGRectGetMaxY(_visitF);
    CGFloat chooseW = 44.0 / 375 * ISScreen_Width;
    CGFloat chooseH = chooseW;
    CGFloat chooseX = ISScreen_Width - Margin - chooseW;
    CGFloat chooseY = maxVisitF - chooseH;
    _chooseF = CGRectMake(chooseX, chooseY, chooseW, chooseH);
    
    // "选择此模板"
    NSString *chooseText = @"选择此模板";
    CGSize chooseTextSize = [chooseText sizeWithWidth:MAXFLOAT font:ISFont_14];
    CGFloat chooseTextW = chooseTextSize.width;
    CGFloat chooseTextH = chooseTextSize.height;
    CGFloat chooseTextX = chooseX - 10.0 / 375 * ISScreen_Width - chooseTextW;
    CGFloat chooseTextY = maxVisitF - chooseTextH;
    _chooseTextF = CGRectMake(chooseTextX, chooseTextY, chooseTextW, chooseTextH);
    
    // 视频缩略图
//    CGFloat thumbX = 0;
//    CGFloat thumbW = ISScreen_Width;
//    CGFloat thumbY = maxVisitF + Margin;
//    CGFloat thumbRatio = 426.0 / 750;
//    CGFloat thumbH = thumbRatio * ISScreen_Width;
//    _thumbF = CGRectMake(thumbX, thumbY, thumbW, thumbH);
    _thumbF = CGRectMake(0, 0, ISScreen_Width - 12, 128);
    
    // 播放按钮
//    CGFloat playW = 117.0 / 375 * ISScreen_Width;
//    CGFloat playH = playW;
//    CGFloat playX = (ISScreen_Width - playW) * 0.5;
//    CGFloat playY = (thumbH - playH) * 0.5 + thumbX;
//    _playButtonF = CGRectMake(playX, playY, playW, playH);
    _playButtonF = CGRectMake(ISScreen_Width / 2 - 33, 66, 66, 66);
    
    // 简介
    CGFloat introX = iconX;
    CGFloat introY = CGRectGetMaxY(_thumbF) + Margin;
    NSString *intro = [NSString stringWithFormat:@"简介: %@", styleDetail.intro];
    if (intro.length > 22) {    // 简介不超过22个字
        intro = [intro substringToIndex:22];
        intro = [NSString stringWithFormat:@"%@...", intro];
    }
    CGFloat introW = ISScreen_Width - Margin * 2;
    CGSize introSize = [intro sizeWithWidth:introW font:ISFont_12];
    _introF = CGRectMake(introX, introY, introW, introSize.height);
    
    // 应用场景
    CGFloat senceX = introX;
    CGFloat senceY = CGRectGetMaxY(_introF) + 20.0 / 667 * ISScreen_Height;
    CGFloat senceW = introW;
    NSString *sence = [NSString stringWithFormat:@"应用场景: %@", styleDetail.sence];
    if (sence.length > 22) {    // 简介不超过22个字
        sence = [intro substringToIndex:22];
        sence = [NSString stringWithFormat:@"%@...", sence];
    }
    CGSize senceSize = [sence sizeWithWidth:senceW font:ISFont_12];
    _senceF = CGRectMake(senceX, senceY, senceW, senceSize.height);
    
    // 分割线
    CGFloat lineX = senceX;
    CGFloat lineW = ISScreen_Width - lineX * 2;
    CGFloat lineY = CGRectGetMaxY(_senceF) + Margin;
    _lineF = CGRectMake(lineX, lineY, lineW, 1);
    
    // cell 高度
    _cellH = CGRectGetMaxY(_lineF);
}

@end


#pragma mark ----- ISStyleDetailCell
@interface ISStyleDetailCell () <OssFileDownDelegate>
/**  图标 */
@property (weak, nonatomic) UIImageView *iconView;
/**  标题 */
@property (weak, nonatomic) UILabel *titleLabel;
/**  查看次数 */
@property (weak, nonatomic) UILabel *visitLabel;
/**  选择按钮 */
@property (weak, nonatomic) UIButton *chooseButton;
/**  "选择此模板" 文字 */
@property (weak, nonatomic) UILabel *chooseTextLabel;
/**  缩略图  的父视图,, 播放器也添加在这个控件上  */
@property (weak, nonatomic) UIView *playerView;
/**  缩略图 */
@property (weak, nonatomic) UIImageView *thumbView;
/**  视频播放按钮 */
@property (weak, nonatomic) UIButton *playButton;
/**  简介 */
@property (weak, nonatomic) UILabel *introLabel;
/**  应用场景 */
@property (weak, nonatomic) UILabel *senceLabel;
/**  分割线 */
@property (weak, nonatomic) UIView *lineView;

/**  视频播放器 */
//@property (strong, nonatomic) NGMoviePlayer *player;
@property (strong,nonatomic)MPMoviePlayerViewController *mpplayer;
/**  视频播放器 控制按钮 */
@property (weak, nonatomic)  UIButton *playerControl;

@property(weak,nonatomic)MBProgressHUD *hud;
@end


@implementation ISStyleDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView  andIndex:(NSIndexPath *)index{
    NSString *ID = [NSString stringWithFormat:@"styleDetail%ld", (long)index.row];
    ISStyleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ISStyleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
   
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 点击cell时不会变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = ISBackgroundColor;
        
        // 创建视图
        [self setupViews];
    }
    return self;
}

//- (NGMoviePlayer *)player {
//    if (!_player) {
//        self.player = [[NGMoviePlayer alloc] init];
//    }
//    return _player;
//}

- (void)setupViews {
//    /**  图标 */
//    UIImageView *iconView = [[UIImageView alloc] init];
//    iconView.image = [UIImage imageNamed:@"film"];
//    [self.contentView addSubview:iconView];
//    self.iconView = iconView;
//    
//    /**  标题 */
//    UILabel *titleLabel = [[UILabel alloc] init];
//    titleLabel.font = ISFont_15;
//    titleLabel.textColor = ISFontColor;
//    [self.contentView addSubview:titleLabel];
//    self.titleLabel = titleLabel;
//    
//    /**  查看次数 */
//    UILabel *visitLabel = [[UILabel alloc] init];
//    visitLabel.font = ISFont_12;
//    visitLabel.textColor = ISFontColor;
//    [self.contentView addSubview:visitLabel];
//    self.visitLabel = visitLabel;
//    
//    /**  选择按钮 */
//    UIButton *chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [chooseButton setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
//    [chooseButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
//    [chooseButton addTarget:self action:@selector(chooseTemplate:) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:chooseButton];
//    self.chooseButton = chooseButton;
//    
//    /**  "选择此模板" 文字 */
//    UILabel *chooseTextLabel = [[UILabel alloc] init];
//    chooseTextLabel.font = ISFont_14;
//    chooseTextLabel.textColor = ISFontColor;
//    [self.contentView addSubview:chooseTextLabel];
//    self.chooseTextLabel = chooseTextLabel;
    
    /**  缩略图 */
    UIView *playerView = [[UIView alloc] init];
    [self.contentView addSubview:playerView];
    self.playerView = playerView;
    // 添加播放器
//    [self.player addToSuperview:playerView withFrame:playerView.bounds];
//    self.player.delegate = self;
//    self.player.autostartWhenReady = NO;
//    self.player.view.controlsView.hidden = YES;
//    self.player.view.controlsView.playPauseControl.selected = NO;
//    [self.player.view.controlsView handlePlayPauseButtonPress:self.player.view.controlsView.playPauseControl];
    self.mpplayer = [[MPMoviePlayerViewController alloc] initWithContentURL:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:[self.mpplayer moviePlayer]];
    // add to view
    [self.mpplayer.view setFrame:self.playerView.bounds];
    [self.playerView addSubview:self.mpplayer.view];
    [self.mpplayer moviePlayer].controlStyle = MPMovieControlStyleNone;
    [self.mpplayer moviePlayer].shouldAutoplay = YES;
    [self.mpplayer moviePlayer].repeatMode = MPMovieRepeatModeNone;
//    [[self.mpplayer moviePlayer] setFullscreen:YES animated:YES];
    [self.mpplayer moviePlayer].scalingMode = MPMovieScalingModeAspectFit;
    
    /**  缩略图 */
    UIImageView *thumbView = [[UIImageView alloc] init];
    thumbView.contentMode = UIViewContentModeScaleAspectFit;
    thumbView.clipsToBounds = YES;
    [playerView addSubview:thumbView];
    self.thumbView = thumbView;
    /**  播放按钮 */
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [playButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
    [playButton addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventTouchUpInside];
    [playerView addSubview:playButton];
    self.playButton = playButton;
    
//    /**  简介 */
//    UILabel *introLabel = [[UILabel alloc] init];
//    introLabel.font = ISFont_14;
//    introLabel.textColor = ISFontColor;
//    [self.contentView addSubview:introLabel];
//    self.introLabel = introLabel;
//    
//    /**  应用场景 */
//    UILabel *senceLabel = [[UILabel alloc] init];
//    senceLabel.font = ISFont_14;
//    senceLabel.textColor = ISFontColor;
//    [self.contentView addSubview:senceLabel];
//    self.senceLabel = senceLabel;
//    
//    /**  分割线 */
//    UIView *lineView = [[UIView alloc] init];
//    lineView.backgroundColor = ISRGBColor(210, 210, 210);
//    [self.contentView addSubview:lineView];
//    self.lineView = lineView;
}

- (void)setStyleF:(ISStyleDetailFrame *)styleF {
    _styleF = styleF;
    ISStyleDetail *styleDetail = styleF.styleDetail;
    
//    /**  图标 */
//    self.iconView.frame = styleF.iconF;
//    
//    // 标题
//    self.titleLabel.frame = styleF.titleF;
//    self.titleLabel.text = styleDetail.title;
//    
//    // 查看次数
//    self.visitLabel.frame = styleF.visitF;
//    self.visitLabel.text = [NSString stringWithFormat:@"%@次查看", styleDetail.visitCount];
//    
//    /**  选择按钮 */
//    self.chooseButton.frame = styleF.chooseF;
//    
//    /**  "选择此模板" 文字 */
//    self.chooseTextLabel.frame = styleF.chooseTextF;
//    self.chooseTextLabel.text = @"选择此模板";
    
    /**  缩略图  的父视图,, 播放器也添加在这个控件上  */
//    self.playerView.frame = styleF.thumbF;
    self.playerView.frame = CGRectMake(0, 0, ISScreen_Width - 12, (ISScreen_Width - 12) / 16 * 9);
    self.thumbView.frame = self.playerView.bounds;
    [self.thumbView sd_setImageWithURL:[NSURL URLWithString:styleDetail.thumbnail]];
    self.playButton.frame = styleF.playButtonF;
    
//    // 简介
//    NSString *intro = [NSString stringWithFormat:@"简介: %@", styleDetail.intro];
//    if (intro.length > 22) {    // 简介不超过22个字
//        intro = [intro substringToIndex:22];
//        intro = [NSString stringWithFormat:@"%@...", intro];
//    }
//    self.introLabel.frame = styleF.introF;
//    self.introLabel.text = intro;
//    
//    // 应用场景
//    NSString *sence = [NSString stringWithFormat:@"应用场景: %@", styleDetail.sence];
//    if (sence.length > 22) {    // 简介不超过22个字
//        sence = [intro substringToIndex:22];
//        sence = [NSString stringWithFormat:@"%@...", sence];
//    }
//    self.senceLabel.frame = styleF.senceF;
//    self.senceLabel.text = sence;
//    
//    /**  分割线 */
//    self.lineView.frame = styleF.lineF;
}

- (void)chooseTemplate:(UIButton *)button {
    button.selected = !button.selected;
    // 下面一行代码 可能会不管用, 移到控制器中
//    self.styleF.styleDetail.isSelected = button.selected;
    if ([self.delegate respondsToSelector:@selector(styleCell:didClickChooseButton:)]) {
        [self.delegate styleCell:self didClickChooseButton:button];
    }
}

/**  取消当前选中的模板 */
- (void)deselectCurrentTemplate:(ISStyleDetailCell *)cell {
    cell.chooseButton.selected = NO;
}

/**  取消当前的模板的视频播放 */
- (void)cancleCurrentTemplatePlaying:(ISStyleDetailCell *)cell {
//    [cell.player.view.controlsView handlePlayPauseButtonPress:self.player.view.controlsView.playPauseControl];
//    [cell.player setURL:nil];
//    [cell.player pause];
    [[self.mpplayer moviePlayer] stop];
    cell.isPlaying = NO;
    cell.thumbView.hidden = NO;
    cell.playButton.selected = NO;
    cell.playButton.hidden = NO;
}

-(void)moviePlayBackDidFinish:(NSNotification*)notification{
    
    [self.mpplayer moviePlayer].contentURL = nil;
    self.thumbView.hidden = NO;
    self.playButton.selected = NO;
    self.playButton.hidden = NO;
    self.isPlaying = NO;
    if ([self.delegate respondsToSelector:@selector(styleCell:isPlaying:)]) {
        [self.delegate styleCell:self isPlaying:self.isPlaying];
    }
    [[self.mpplayer moviePlayer] stop];
}

/**  此按钮只控制开始播放, 停止播放是在选中下一个模板或者播放完毕 */
- (void)playClick:(UIButton *)button {
    self.thumbView.hidden = YES;    // 隐藏图片
    ////20160117 arbin 添加下载模块
    NSString *filename = self.styleF.styleDetail.videoUrl;
    filename = [filename lastPathComponent];
    NSString *filepath = [self dirDoc];
    filepath = [filepath stringByAppendingFormat:@"/%@",filename];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:filepath])
        [self startPlay:button Local:filepath];
    else{
        MBProgressHUD *newhud = [MBProgressHUD showHUDAddedTo:self.mpplayer.view animated:YES];
//        newhud.mode = MBProgressHUDModeAnnularDeterminate;
        newhud.labelText = @"加载...";
        self.hud = newhud;
        self.playButton.hidden = YES;
        [OssFileDown Singleton].delegate = self;
        [[OssFileDown Singleton] SimpleDown:self.styleF.styleDetail.videoUrl EXt:@"mp4" LocalFile:filepath];
    }
}

-(void)startPlay:(UIButton *)button Local:(NSString*)playurl{
    NSURL* url = [NSURL fileURLWithPath:playurl];
//    [self.player setURL:url title:self.styleF.styleDetail.title];
//    [self.player.view.controlsView handlePlayPauseButtonPress:self.player.view.controlsView.playPauseControl];
    
    // play movie
    [self.mpplayer moviePlayer].contentURL = url;
    [[self.mpplayer moviePlayer] play];
    
    self.playButton.hidden = YES;
    [self.playerView bringSubviewToFront:self.playButton];
    self.isPlaying = YES;
    if ([self.delegate respondsToSelector:@selector(styleCell:isPlaying:)]) {
        [self.delegate styleCell:self isPlaying:self.isPlaying];
    }
    button.selected = !button.selected;
}

#pragma mark --- NGMoviePlayerDelegate
//- (void)moviePlayer:(NGMoviePlayer *)moviePlayer didFinishPlaybackOfURL:(NSURL *)URL {
//    [self.player setURL:nil];
//    self.thumbView.hidden = NO;
//    self.playButton.selected = NO;
//    self.playButton.hidden = NO;
//    self.isPlaying = NO;
//    if ([self.delegate respondsToSelector:@selector(styleCell:isPlaying:)]) {
//        [self.delegate styleCell:self isPlaying:self.isPlaying];
//    }
//    [self.player pause];
//}
//
//- (void)moviePlayer:(NGMoviePlayer *)moviePlayer didStartPlaybackOfURL:(NSURL *)URL{
//    self.player.autostartWhenReady = NO;
//}

//创建文件
-(void)createFile:(NSString*)filepath FileData:(NSData*)fdata{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL res=[fileManager createFileAtPath:filepath contents:fdata attributes:nil];
    if (res) {
        NSLog(@"文件创建并写入成功: %@" ,filepath);
    }else
        NSLog(@"文件创建失败或写入失败");
    return;
}

//获取Documents目录
-(NSString *)dirDoc{
    //[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSLog(@"app_home_doc: %@",documentsDirectory);
    return documentsDirectory;
}

/**  当前下载百分比 */
- (void)OssFileDown:(OssFileDown *)pointdownself Process:(float)download{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hud.progress = download;
    });

}
/**  下载完成/下载失败 */
- (void)OssFileDown:(OssFileDown *)pointdownself Status:(BOOL)downsuccess Fileinfo:(NSString *)filepath{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.hud hide:YES];
        [self startPlay:nil Local:filepath];;
    });
}
@end
