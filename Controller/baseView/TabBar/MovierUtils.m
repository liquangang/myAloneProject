//
//  MovierUtils.m
//  M-Cut
//
//  Created by Crab00 on 15/7/30.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "MovierUtils.h"
#import "UMSocial.h"
#import "Reachability.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation MovierUtils

+ (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+ (NSString *)stringFromDateaa:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddhhmmss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+(void)videoWithUrl:(NSURL *)url withFileName:(NSString *)fileName
{
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
    if (url) {
        [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset) {
            ALAssetRepresentation *rep = [asset defaultRepresentation];
            char const *cvideoPath = [fileName UTF8String];
            FILE *file = fopen(cvideoPath, "a+");
            if (file) {
                const int bufferSize = 1024 * 1024;
                Byte *buffer = (Byte*)malloc(bufferSize);
                NSUInteger read = 0, offset = 0, written = 0;
                NSError* err = nil;
                if (rep.size != 0)
                {
                    do {
                        read = [rep getBytes:buffer fromOffset:offset length:bufferSize error:&err];
                        written = fwrite(buffer, sizeof(char), read, file);
                        offset += read;
                    } while (read != 0 && !err);
                }
                free(buffer);
                buffer = NULL;
                fclose(file);
                file = NULL;
            }
        } failureBlock:nil];
    }
}

//+(void)userUMshare:(NSString*)title videourl:(NSString*)url videoId:(NSString*)vid videothumbnail:(UIImage*)image UMdelegate:(id)dele parentview:(){
//    NSString *videoUrl = [[NSString alloc] initWithFormat:shareURL,vid];
//    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeVideo url:videoUrl];
//    NSString *showmes;
//    if ([title isEqualToString:@""]) {
//        showmes = @"映像让记忆更精彩！";
//    }else
//        showmes =title;
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"55f9088b67e58e3dbd000488"
//                                      shareText:showmes
//                                     shareImage:image
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,nil]
//                                       delegate:dele];
//}

+(UIImage *)getImageFromImage:(UIImage *)in scale:(float)tosize{
    int min = in.size.width > in.size.height ? in.size.height : in.size.width;
    if(min < 1){
        return [UIImage imageNamed:@"Default"];
    }
    CGRect myImageRect;
    if(min == in.size.width){
        myImageRect = CGRectMake(0,(in.size.height-in.size.width)/2,min,min);
    }else{
        myImageRect = CGRectMake((in.size.width-in.size.height)/2,0,min,min);
    }
    CGImageRef imageRef = in.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    CGSize size;
    size.width = min;
    size.height = min;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myImageRect, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    float scaleSize = (float)tosize/min;
    if(scaleSize < 1){
        UIGraphicsBeginImageContext(CGSizeMake(smallImage.size.width*scaleSize, smallImage.size.width*scaleSize));
        [smallImage drawInRect:CGRectMake(0,0,smallImage.size.width*scaleSize,smallImage.size.height*scaleSize)];
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        //        NSData * imageData = UIImageJPEGRepresentation(scaledImage,1);
        //        float length = [imageData length]/1024;
        return scaledImage;
    }else
        return smallImage;
}

+(UIImage *)getSquareImage:(UIImage *)in{
//    NSLog(@"before size = %@",NSStringFromCGSize(in.size));
    int min = in.size.width > in.size.height ? in.size.height : in.size.width;
    if(min < 1){
        return [UIImage imageNamed:@"Default"];
    }
    CGRect myImageRect;
    if(min == in.size.width){
        myImageRect = CGRectMake(0,(in.size.height-in.size.width)/2,min,min);
    }else{
        myImageRect = CGRectMake((in.size.width-in.size.height)/2,0,min,min);
    }
    CGImageRef imageRef = in.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    CGSize size;
    size.width = min;
    size.height = min;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myImageRect, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    return smallImage;
}

+(NSString*)GetCurrntNet
{
    NSString* result;
    Reachability *r = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            result=nil;
            break;
        case ReachableViaWWAN:
            result=@"3g";
            break;
        case ReachableViaWiFi:
            result=@"wifi";
            break;
    }
    return result;
}

@end
