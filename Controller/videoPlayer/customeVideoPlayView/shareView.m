//
//  shareView.m
//  M-Cut
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "shareView.h"
#import "SubShareView.h"
#import "ShareCollectionViewCell.h"

static NSString *const resuableItemStr = @"ShareCollectionViewCell";

@interface shareView()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSArray * imageNameArray; //保存图片名字的数组（图片需要放在项目中，图片名称字符串数组）
@property (nonatomic, strong) NSArray * nameArray;  //分享的平台名称(名称字符串数组)
@property (nonatomic, strong) UICollectionView *shareCollectionView;
@end

@implementation shareView

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.nameArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:resuableItemStr forIndexPath:indexPath];
    cell.shareImage.image = [UIImage imageNamed:self.imageNameArray[indexPath.item]];
    cell.shareTitle.text = self.nameArray[indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.shareTapBlock(indexPath.item);
}

#pragma mark - interface

- (instancetype)initWithFrame:(CGRect)frame
                   ImageArray:(NSArray *)imageArray
                    NameArray:(NSArray *)nameArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageNameArray = imageArray;
        self.nameArray = nameArray;
        [self createUIWithIsHiddenTuwenshareButton:NO];
    }
    return self;
}

- (instancetype)init2WithFrame:(CGRect)frame
                   ImageArray:(NSArray *)imageArray
                    NameArray:(NSArray *)nameArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageNameArray = imageArray;
        self.nameArray = nameArray;
        [self createUIWithIsHiddenTuwenshareButton:YES];
    }
    return self;
}

- (void)createUIWithIsHiddenTuwenshareButton:(BOOL)isHiddenShareButton{
    self.backgroundColor = ColorFromRGB(0x000000, 0.3);
    
    //放所有分享view的view
    UIView * shareSubView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                     self.bounds.size.height - 96 - CGRectGetHeight(self.shareCollectionView.frame),
                                                                     ISScreen_Width,
                                                                     96 + CGRectGetHeight(self.shareCollectionView.frame))];
    

    if (isHiddenShareButton) {
        shareSubView.frame = CGRectMake(0,
                                        shareSubView.frame.origin.y + 44,
                                        ISScreen_Width,
                                        shareSubView.frame.size.height - 44);
    }
    
    [self addSubview:shareSubView];
    shareSubView.backgroundColor = UIColorFromRGB(0x2E2E3A);
    
    //其余部分的隐藏按钮
    UIButton * hiddenButton = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                         0,
                                                                         ISScreen_Width,
                                                                         self.bounds.size.height - shareSubView.bounds.size.height)];
    [self addSubview:hiddenButton];
    [hiddenButton addTarget:self action:@selector(hiddenButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [shareSubView addSubview:self.shareCollectionView];
    
    //中间的横线
    UILabel * lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                    CGRectGetHeight(self.shareCollectionView.frame),
                                                                    ISScreen_Width,
                                                                    1)];
    lineLabel.backgroundColor = UIColorFromRGB(0x272732);
    [shareSubView addSubview:lineLabel];
    
    //图文分享按钮
    UIButton * shareButton = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                        lineLabel.frame.origin.y + 1,
                                                                        ISScreen_Width,
                                                                        44)];
    
    if (isHiddenShareButton) {
        shareButton.frame = CGRectMake(0, lineLabel.frame.origin.y, 0, 0);
    }
    
    [shareButton setTitle:@"图文分享" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor whiteColor]
                      forState:UIControlStateNormal];
    shareButton.titleLabel.font = ISFont_15;
    [shareButton addTarget:self action:@selector(tuwenShareAction:)
          forControlEvents:UIControlEventTouchUpInside];
    [shareSubView addSubview:shareButton];
    shareButton.backgroundColor = UIColorFromRGB(0x2E2E3A);
    
    //下面的横线
    UILabel * lineLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                     shareButton.frame.origin.y + shareButton.frame.size.height,
                                                                     ISScreen_Width,
                                                                     7)];
    [shareSubView addSubview:lineLabel2];
    lineLabel2.backgroundColor = UIColorFromRGB(0x272732);
    
    //取消按钮
    UIButton * cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                         lineLabel2.frame.origin.y + lineLabel2.frame.size.height,
                                                                         ISScreen_Width,
                                                                         44)];
    [shareSubView addSubview:cancleButton];
    [cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    cancleButton.backgroundColor = UIColorFromRGB(0x2E2E3A);
    [cancleButton addTarget:self
                     action:@selector(cancleButtonAction:)
           forControlEvents:UIControlEventTouchUpInside];
    cancleButton.titleLabel.font = ISFont_15;
}

/**
 *  隐藏
 */
- (void)hiddenButtonAction:(UIButton *)btn{
    self.cancleBlock();
}

/**
 *  取消按钮
 */
- (void)cancleButtonAction:(UIButton *)btn{
    self.cancleBlock();
}

/**
 *  图文分享按钮
 */
- (void)tuwenShareAction:(UIButton *)btn{
    self.tuwenShareBlock();
}

/**
 *  分享方法
 */
- (void)shareThirdParty:(UIGestureRecognizer *)tap{
    SubShareView * subShareView = (SubShareView *)tap.view;
    self.shareTapBlock(subShareView.tag - 123456);
}

#pragma mark - getter

- (UICollectionView *)shareCollectionView{
    if (!_shareCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        flowLayout.itemSize = CGSizeMake(75, 60);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        
        _shareCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 95) collectionViewLayout:flowLayout];
        [_shareCollectionView registerNib:[UINib nibWithNibName:resuableItemStr bundle:nil] forCellWithReuseIdentifier:resuableItemStr];
        _shareCollectionView.delegate = self;
        _shareCollectionView.dataSource = self;
        _shareCollectionView.showsHorizontalScrollIndicator = NO;
        _shareCollectionView.decelerationRate = 1;
        _shareCollectionView.backgroundColor = UIColorFromRGB(0x2E2E3A);
    }
    return _shareCollectionView;
}

@end
