//
//  VideoLabelView.m
//  M-Cut
//
//  Created by liquangang on 16/9/8.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "VideoLabelView.h"
#import "SoapOperation.h"
#import "ISConst.h"
#import "HomePageLabelModel.h"
#import "CustomeClass.h"

@interface VideoLabelView()
@property (nonatomic, strong) NSMutableArray * videoLabelDataMuArray;
@end

@implementation VideoLabelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ISe6e6e6;
        [self setAboveLabel];
    }
    return self;
}

- (void)setAboveLabel{
    DEFAULTQUEUEANALYSISANDMAINQUEUEUPDATEUI({
        WEAKSELF(weakSelf);
        [[SoapOperation Singleton] WS_getvideolabelsexWithVideoLabelLocation:1 Offset:0 Count:66 Success:^(NSMutableArray *serverDataArray) {
            for (MovierDCInterfaceSvc_VDCVideoLabelEx2 *labelInfo in serverDataArray) {
                HomePageLabelModel *labelModel = [HomePageLabelModel new];
                labelModel.labelInfo = labelInfo;
                [weakSelf.videoLabelDataMuArray addObject:labelModel];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                CGRect lastRect = CGRectMake(0, 10, 0, 0);
                int i = 0;
                for (MovierDCInterfaceSvc_VDCVideoLabelEx2 * videoLabelInfo in serverDataArray) {
                    
                    
                    //先计算文字所占的大小，然后判断之前的那个label的位置，然后确定当前label的位置 最后lastRect 等于当前的这个label的cgrect
                    UILabel * currentLabel = [UILabel new];
                    
                    currentLabel.layer.borderColor = IS65656d.CGColor;
                    currentLabel.layer.borderWidth = 1;
                    currentLabel.layer.masksToBounds = YES;
                    currentLabel.layer.cornerRadius = 5;
                    currentLabel.text = [NSString stringWithFormat:@"%@", videoLabelInfo.szLabelName];
                    currentLabel.textAlignment = NSTextAlignmentCenter;
                    currentLabel.textColor = IS2e2e3a;
                    currentLabel.font = ISFont_12;
                    
                    if (i == 0) {
                        currentLabel.frame = CGRectMake(16, 10, ISScreen_Width / 2 - 24, 24);
                        //添加到父view上
                        [weakSelf addSubview:currentLabel];
                        lastRect = currentLabel.frame;
                        currentLabel.tag = 100 + i;
                        i++;
                        
                        //添加点击手势
                        ADDTAPGESTURE(currentLabel, videoLabelTap)
                        continue;
                    }
                    
                    if (i == 1) {
                        currentLabel.frame = CGRectMake(ISScreen_Width / 2 + 8, 10, ISScreen_Width / 2 - 24, 24);
                        //添加到父view上
                        [weakSelf addSubview:currentLabel];
                        lastRect = currentLabel.frame;
                        currentLabel.tag = 100 + i;
                        i++;
                        
                        //添加点击手势
                        ADDTAPGESTURE(currentLabel, videoLabelTap)
                        continue;
                    }
                    
                    //计算label的初始位置(x:上一个label的x＋它的width ＋ 15（加上自己的width 如果大于屏幕宽 就下移）   y 默认不变)
                    CGFloat LabelX = lastRect.origin.x + lastRect.size.width + 16;
                    CGFloat labelY = lastRect.origin.y;
                    
                    //cell内容的大小
                    CGSize contentSize = [currentLabel.text sizeWithAttributes:@{NSFontAttributeName:ISFont_12}];
                    
                    //确定cell的起始坐标点
                    if ((LabelX + contentSize.width + 54) > ISScreen_Width) {
                        LabelX = 16;
                        labelY = lastRect.origin.y + lastRect.size.height + 10;
                    }
                    
                    //如果可以添加就添加，不可以就不添加
                    if (!(labelY > 78 || (labelY > 78 && (LabelX + contentSize.width + 54) > ISScreen_Width))) {
                        //如果没有被break，说明可以继续添加，设置已经判断好的label 的rect
                        currentLabel.frame = CGRectMake(LabelX, labelY, contentSize.width + 32, 24);
                        
                        //添加到父view上
                        [weakSelf addSubview:currentLabel];
                        lastRect = currentLabel.frame;
                        currentLabel.tag = 100 + i;
                        i++;
                        
                        //添加点击手势
                        ADDTAPGESTURE(currentLabel, videoLabelTap)
                    }
                }
            });
        } Fail:^(NSError *error) {
            RELOADSERVERDATA([weakSelf setAboveLabel];)
        }];
    }, {})
}

- (void)videoLabelTap:(UITapGestureRecognizer *)tap{
    POSTNOTI(PUSHTOVIDEOLABELDETAILVC, (@{@"videoLabelInfo":self.videoLabelDataMuArray[tap.view.tag - 100]}));
}

- (NSMutableArray *)videoLabelDataMuArray{
    LAZYINITMUARRAY(_videoLabelDataMuArray)
}

@end
