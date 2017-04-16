//
//  MoviePlayerViewController.m
//  M-Cut
//
//  Created by Kyle on 14/12/22.
//  Copyright (c) 2014年 Crab movier. All rights reserved.
//

#import "MoviePlayerViewController.h"

@interface MoviePlayerViewController (LocalMovieURL)

-(NSURL *)localMovieURL;

@end

#pragma mark -
@implementation MoviePlayerViewController (LocalMovieURL)


/* Returns a URL to a local movie in the app bundle. */
-(NSURL *)localMovieURL
{
    NSURL *theMovieURL = nil;
    NSBundle *bundle = [NSBundle mainBundle];
    if (bundle)
    {
        NSString *moviePath = [bundle pathForResource:@"Movie" ofType:@"m4v"];
        if (moviePath)
        {
            theMovieURL = [NSURL fileURLWithPath:moviePath];
        }
    }
    return theMovieURL;
}

-(NSURL*)downMovierURL
{
    NSString* filepath = [self writeFile:self.playfilename];

    return [NSURL fileURLWithPath:filepath];
}

-(NSString *)writeFile:(NSString *)file{
    
    //创建文件管理器
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //获取路径
    
    //参数NSDocumentDirectory要获取那种路径
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];//去处需要的路径
    
    //更改到待操作的目录下
    
    [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
    
    //创建文件fileName文件名称，contents文件的内容，如果开始没有内容可以设置为nil，attributes文件的属性，初始为nil
    
    //获取文件路径
    
    [fileManager removeItemAtPath:file error:nil];
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:file];
    
    //创建数据缓冲
    NSMutableData *writer = [[NSMutableData alloc] init];
    
    //将字符串添加到缓冲中
    
    [writer appendData:self.playdata];
    
    //将其他数据添加到缓冲中
    
    //将缓冲的数据写入到文件中
    
    [writer writeToFile:path atomically:YES];
    
    return path;
    
}

@end

#pragma mark -

@implementation MoviePlayerViewController
@synthesize playdata = _playdata;
@synthesize playfilename = _playfilename;
@synthesize playURL = _playURL;
/* Button presses for the 'Play Movie' button. */


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self playMovieStream:[NSURL URLWithString:self.playURL]];
//     [self playMovieFile:[self downMovierURL]];
}

- (IBAction)returnToFirstPage:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end

