//
//  leadPage2.m
//  myPro1207_tab
//
//  Created by zhangxiaotian on 15/12/7.
//  Copyright © 2015年 Xuzihao. All rights reserved.
//

#import "leadPage.h"
#import "ISConst.h"

#define FIRST                   @"1"
#define SECOND                  @"2"
#define THIRD                   @"3"
#define MAINSIZE                [UIScreen mainScreen].bounds.size
#define FIRSTIMG                @"makeLeadPage"
#define FIRSTIMGFRAME           @"makeLeadPageFrame"
#define FIRSTIMG1               @"1downLead"
#define FIRSTIMGFRAME1          @"1downLeadF"
#define SECONDIMG               @"adjustOrder"
#define SECONDIMGFRAME          @"adjustOrderFrame"
#define THIRDIMG                @"outLine"
#define THIRDIMGFRAME           @"makeLeadPageFrame"
#define DISTANCELEFTWIDTH       8
#define DISTANCEUPHEIGHT        14
#define DISTANCEDOWNHEIGHT      36
#define DISTANCEDOWNHEIGHT3     350
#define DISTANCEDOWNWIDTH       18
#define VIEWOUTLINEHEIGHT       72.0 / 667 * (ISScreen_Height - ISNavigationHeight - ISTabBarHeight)
#define VIEWOUTLINEIMAGEHEIGHT  117



#define IPHONE5 568
#define IPHONE6 667
#define IPHONEPLUS 736

@interface leadPage ()


//@property (nonatomic, strong)UIImageView *backgroundView;

@end


@implementation leadPage

-(leadPage *)initWithName:(NSString *)pic_Name {

    
    //初始化 半透明 整个页面
    self = [super initWithFrame:CGRectMake(0, 0, MAINSIZE.width , MAINSIZE.height)];
    
    self.backgroundColor = [UIColor blackColor];
    
    [self setFrame:CGRectMake(0, 0, MAINSIZE.width, MAINSIZE.height )];
    
    self.alpha = 0.5;
    
    
    int img_heightTop = 0;
    
    int img_heightBottom = 0;
    //根据当前的屏幕设置导航栏 以及标签栏高度
    if(MAINSIZE.height == IPHONEPLUS)
    {
        img_heightTop = 132 / 2;
        img_heightBottom  = 146 / 2;
    }
    else
    {
        img_heightTop = (88+40) / 2;
        img_heightBottom = 98/2;
    }

    
    
    //imageView  default is can't touch
    self.userInteractionEnabled = YES;
    
    
    //根据 传递来的数据判定 是第几个引导界面
    if(pic_Name != nil)
    {
        if ([pic_Name  isEqual: FIRST])
        {
            NSLog(@"the first name");
            
            [self addSubviewToImgaeView:1  :FIRSTIMGFRAME :FIRSTIMG :DISTANCELEFTWIDTH :DISTANCEUPHEIGHT+img_heightTop ];
            NSLog(@"minsize  %d",img_heightBottom);
            [self addSubviewToImgaeView:2 :FIRSTIMGFRAME1 :FIRSTIMG1 :DISTANCEDOWNWIDTH : MAINSIZE.height -74];
        }
        else if( [ pic_Name isEqual:SECOND])
        {
            NSLog(@"the second name ");
            
            [self addSubviewToImgaeView:3  :SECONDIMGFRAME :SECONDIMG :DISTANCELEFTWIDTH-2 :DISTANCEUPHEIGHT+img_heightTop - 4 ];
        }
        else if( [ pic_Name isEqual:THIRD])
        {
            [self addSubviewToImgaeView:4 :THIRDIMGFRAME :THIRDIMG :2 : img_heightTop+VIEWOUTLINEIMAGEHEIGHT+VIEWOUTLINEHEIGHT*2 ];
        }
        
    }   
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self removeFromSuperview];
    //如何注销掉内存呢;
    
}
//创建一个新的子view在 大的背景view上
/*
 *order 图片顺序 not  page order
 *imgFrame imgName  图片名字
 *distanceLeft distanceHeight 到顶部 左边 或者 底部  右边的距离
 *
 */
-(void) addSubviewToImgaeView:(int) order  :(NSString *) imgFrame :(NSString *) imgName   :(int)distanceLeft :(int)distanceHeight
{
    UIImageView *img_FirFrame = [[UIImageView alloc]init];
  
    UIImageView *img_Fir = [[UIImageView alloc]init];
    
    img_FirFrame.image = [UIImage imageNamed:imgFrame];
    
    img_Fir.image = [UIImage imageNamed:imgName];
    
    [img_FirFrame setBackgroundColor:[UIColor blackColor]];
   // img_FirFrame.backgroundColor = [UIColor blackColor];
    //order means that the page for number
    float pic_Width = 0.0;
   
    float pic_Height = 0.0;
    
    int explainImgW ;
    
    int explainImgY ;
    
    if (order == 1) {
        //每个cell的 宽 和 高度的比例
        pic_Width = (MAINSIZE.width - 10 - 10 -2 * 2)/3;
        
        pic_Height = pic_Width * 0.55;

        explainImgW = distanceLeft+pic_Width;
        
        explainImgY = distanceHeight+pic_Height/2+DISTANCEUPHEIGHT;
    }
    else if(order == 2){
        
        //球的高度
        pic_Width = 31;
        
        pic_Height = 31;
        
        //我必须要知道  slider的高度
        explainImgW = distanceLeft+pic_Width;
        
        explainImgY = distanceHeight - img_FirFrame.image.size.height - img_Fir.image.size.height;
    
        distanceHeight = distanceHeight -30;
    }
    else if(order == 3){
        
        pic_Width = (MAINSIZE.width - 10 - 10 -2 * 2)/3;
        
        pic_Height = pic_Width * 0.55;
        
        explainImgW = distanceLeft+pic_Width;
        
        explainImgY = distanceHeight+pic_Height/2+DISTANCEUPHEIGHT;
    }
    else if(order == 4){
        
        pic_Width = MAINSIZE.width/2;
        
        pic_Height =VIEWOUTLINEHEIGHT * 2 ;
        
        explainImgW = distanceLeft+pic_Width / 2;
        
        explainImgY = distanceHeight-img_Fir.image.size.height;
    }
   
    [img_FirFrame setFrame:CGRectMake(distanceLeft, distanceHeight, pic_Width, pic_Height)];
    
    [self addSubview:img_FirFrame];

    [img_Fir setFrame:CGRectMake(explainImgW ,explainImgY, img_Fir.image.size.width, img_Fir.image.size.height)];
    
    [self addSubview:img_Fir];
}


@end
