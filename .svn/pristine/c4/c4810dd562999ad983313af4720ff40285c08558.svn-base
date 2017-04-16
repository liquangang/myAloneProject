//
//  PPScrollingTableViewCell.m
//  PPImageScrollingTableViewControllerDemo
//
//  Created by popochess on 13/8/10.
//  Copyright (c) 2013年 popochess. All rights reserved.
//

#import "PPImageScrollingTableViewCell.h"
#import "PPImageScrollingCellView.h"


@interface PPImageScrollingTableViewCell() <PPImageScrollingViewDelegate>

@property (strong,nonatomic) UIColor *categoryTitleColor;
@property(strong, nonatomic) PPImageScrollingCellView *imageScrollingView;
@property (strong, nonatomic) NSString *categoryLabelText;

@end

@implementation PPImageScrollingTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initialize];
}

- (void)initialize
{
    // Set ScrollImageTableCellView
//    CGRect rt = self.contentView.frame;
    
    CGRect rt1 = [UIScreen mainScreen].bounds;
    _imageScrollingView = [[PPImageScrollingCellView alloc] initWithFrame:CGRectMake(0., kStartPointY, rt1.size.width*3/4, rt1.size.width/4-1)];
    _imageScrollingView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];    
    // Configure the view for the selected state
}

- (void)setImageData:(NSDictionary*)collectionImageData
{
    [_imageScrollingView setImageData:[collectionImageData objectForKey:@"images"] URL:[collectionImageData objectForKey:@"URL"]];
    _categoryLabelText = [collectionImageData objectForKey:@"category"];
}

- (void)setCategoryLabelText:(NSString*)text withColor:(UIColor*)color{
    
    if ([self.contentView subviews]){
        for (UIView *subview in [self.contentView subviews]) {
            [subview removeFromSuperview];
        }
    }
    UILabel *categoryTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kCategoryLabelWidth, kCategoryLabelHieght)];
    categoryTitle.textAlignment = NSTextAlignmentLeft;
    categoryTitle.text = text;
    categoryTitle.textColor = color;
    categoryTitle.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:categoryTitle];
}
    
- (void) setImageTitleLabelWitdh:(CGFloat)width withHeight:(CGFloat)height {

    [_imageScrollingView setImageTitleLabelWitdh:width withHeight:height];
}

- (void) setImageTitleTextColor:(UIColor *)textColor withBackgroundColor:(UIColor *)bgColor{

    [_imageScrollingView setImageTitleTextColor:textColor withBackgroundColor:bgColor];
}

- (void)setCollectionViewBackgroundColor:(UIColor *)color{
    
    _imageScrollingView.backgroundColor = color;
    [self.contentView addSubview:_imageScrollingView];
}

#pragma mark - PPImageScrollingViewDelegate

- (void)collectionView:(PPImageScrollingCellView *)collectionView didSelectImageItemAtIndexPath:(NSIndexPath*)indexPath {

    [self.delegate scrollingTableViewCell:self didSelectImageAtIndexPath:indexPath atCategoryRowIndex:self.tag];
}

@end
