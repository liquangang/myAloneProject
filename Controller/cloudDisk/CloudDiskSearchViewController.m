//
//  CloudDiskSearchViewController.m
//  M-Cut
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CloudDiskSearchViewController.h"
#import "WaterLayout.h"
#import "ImageCollectionViewCell.h"
#import "ImageHeaderCollectionViewCell.h"
#import "CloudDiskSearchRecordCollectionViewCell.h"
#import "CloudDiskSearchRecordFooterCollectionViewCell.h"
#import "CustomeClass.h"

static NSString *const searchResultCellResuableStr = @"ImageCollectionViewCell";
static NSString *const searchResultHeaderResuableStr = @"ImageHeaderCollectionViewCell";
static NSString *const searchResultFooterResuableStr = @"searchResultFooter";
static NSString *const searchRecordCellResuableStr = @"CloudDiskSearchRecordCollectionViewCell";
static NSString *const searchRecordHeaderResuabelStr = @"searchRecordHeader";
static NSString *const searchRecordFooterResuableStr = @"CloudDiskSearchRecordFooterCollectionViewCell";
static NSString *const searchRecordFileName = @"cloudDiskSearchRecord";

@interface CloudDiskSearchViewController ()<UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UISearchBar *cloudSearchBar;
@property (nonatomic, strong) UICollectionView *searchResultCollectionView;
@property (nonatomic, strong) UICollectionView *searchRecordCollectionView;
@property (nonatomic, strong) NSMutableArray *searchResultMuArray;
@property (nonatomic, strong) NSMutableArray *searchRecordMuArray;
@property (nonatomic, assign) BOOL isShowAllSearchRecord;//是否展示全部搜索记录，默认不展示全部
@property (nonatomic, assign) BOOL isBeginSearch;
@end

@implementation CloudDiskSearchViewController

DEALLOCMETHOD

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self.view addSubview:self.searchResultCollectionView];
    [self.view addSubview:self.searchRecordCollectionView];
    self.searchResultCollectionView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (!self.isBeginSearch) {
        self.isBeginSearch = YES;
        [self.cloudSearchBar becomeFirstResponder];
    }
}

#pragma mark - uicollectionDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if ([collectionView isEqual:self.searchResultCollectionView]) {
        return 0;
    }else{
        if (!self.isShowAllSearchRecord) {
            return self.searchRecordMuArray.count > 2 ? 2 : self.searchRecordMuArray.count;
        }
        return self.searchRecordMuArray.count;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([collectionView isEqual:self.searchResultCollectionView]) {
        ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:searchResultCellResuableStr forIndexPath:indexPath];
        return cell;
    }else{
        CloudDiskSearchRecordCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:searchRecordCellResuableStr forIndexPath:indexPath];
        cell.recordTextLabel.text = self.searchRecordMuArray[indexPath.item];
        
        [cell setDeleteBlock:^{
            WEAKSELF2
            [weakSelf.searchRecordMuArray removeObjectAtIndex:indexPath.item];
            
            [CustomeClass mainQueue:^{
                [weakSelf.searchRecordCollectionView reloadData];
            }];
        }];
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([collectionView isEqual:self.searchResultCollectionView]) {
        
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            ImageHeaderCollectionViewCell *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:searchResultHeaderResuableStr forIndexPath:indexPath];
            header.titleLabel.text = @"     和“搜索文字”有关：";
            return header;
        }else{
            UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:searchResultFooterResuableStr forIndexPath:indexPath];
            return footer;
        }
    }else{
        
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:searchRecordHeaderResuabelStr forIndexPath:indexPath];
            return header;
        }else{
            CloudDiskSearchRecordFooterCollectionViewCell *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:searchRecordFooterResuableStr forIndexPath:indexPath];
            
            if (self.searchRecordMuArray.count > 0) {
                
                if (self.isShowAllSearchRecord) {
                    footer.functionImage.image = [UIImage imageNamed:@"删除"];
                    footer.titleLabel.text = @"清除历史记录";
                }else if (self.searchRecordMuArray.count > 2){
                    footer.functionImage.image = [UIImage imageNamed:@"查看全部记录"];
                    footer.titleLabel.text = @"查看全部记录";
                }
                
                [footer setTapBlock:^{
                    WEAKSELF2
                    [weakSelf searchRecordFooterTap];
                }];
            }else{
                footer.functionImage.image = [UIImage new];
                footer.titleLabel.text = @"";
            }
            return footer;
        }
    }
}

#pragma mark - uicollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([collectionView isEqual:self.searchResultCollectionView]) {
        
    }else{
        [self showSearchResult];
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self addSearchRecordWithText:searchBar.text];
    [self showSearchResult];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [self showSearchRecord];
    return YES;
}

#pragma mark - interface

- (IBAction)cancleButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showSearchRecord{
    self.searchRecordCollectionView.hidden = NO;
    self.searchResultCollectionView.hidden = YES;
    self.isShowAllSearchRecord = NO;
    [self.searchRecordMuArray removeAllObjects];
    [self.searchRecordMuArray addObjectsFromArray:[CustomeClass readDataWithPlistName:searchRecordFileName]];
    [self.searchRecordCollectionView reloadData];
}

- (void)searchRecordFooterTap{
    WEAKSELF2
    
    if (weakSelf.isShowAllSearchRecord && weakSelf.searchRecordMuArray.count > 2) {
        
        //清除所有记录
        [CustomeClass saveDataWithArray:@[] PlistName:searchRecordFileName];
        [weakSelf.searchRecordMuArray removeAllObjects];
    }else{
        
        //查看所有记录
        weakSelf.isShowAllSearchRecord = YES;
    }
    
    [CustomeClass mainQueue:^{
        [weakSelf.searchRecordCollectionView reloadData];
        [weakSelf.cloudSearchBar resignFirstResponder];
    }];
}

- (void)addSearchRecordWithText:(NSString *)searchText{
    
    if (self.searchRecordMuArray.count > 8) {
        [self.searchRecordMuArray removeLastObject];
    }
    
    [self.searchRecordMuArray insertObject:searchText atIndex:0];
    [CustomeClass saveDataWithArray:[self.searchRecordMuArray copy] PlistName:searchRecordFileName];
}

- (void)removeOneRecordWithIndex:(NSIndexPath *)indexPath{
    WEAKSELF2
    [weakSelf.searchRecordMuArray removeObjectAtIndex:indexPath.item];
    [weakSelf updateRecord];
}

- (void)updateRecord{
    [CustomeClass saveDataWithArray:[self.searchRecordMuArray copy] PlistName:searchRecordFileName];
    
    [CustomeClass mainQueue:^{
        WEAKSELF2
        [weakSelf showSearchRecord];
    }];
}

- (void)showSearchResult{
    [self.cloudSearchBar resignFirstResponder];
    self.searchResultCollectionView.hidden = NO;
    self.searchRecordCollectionView.hidden = YES;
    [self.searchResultCollectionView reloadData];
}


#pragma mark - getter

- (UICollectionView *)searchResultCollectionView{
    
    if (!_searchResultCollectionView) {
        WaterLayout *waterLayout = [WaterLayout new];
        waterLayout.rowMargin = 16;
        waterLayout.columnMargin = 16;
        waterLayout.columnsCount = 4;
        waterLayout.sectionEdgeInset = UIEdgeInsetsMake(16, 16, 16, 16);
        
        [waterLayout setItemHeightBlock:^CGFloat(NSIndexPath *indexPath, CGFloat width) {
            return width;
        }];
        
        [waterLayout setHeaderSizeBlock:^CGSize(NSIndexPath *indexPath) {
            return CGSizeMake(ISScreen_Width, 30);
        }];
        
        [waterLayout setFooterSizeBlock:^CGSize(NSIndexPath *indexPath) {
            return CGSizeMake(ISScreen_Width, 0);
        }];
        
        _searchResultCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, ISScreen_Width, ISScreen_Height) collectionViewLayout:waterLayout];
        _searchResultCollectionView.delegate = self;
        _searchResultCollectionView.dataSource = self;
        
        [_searchResultCollectionView registerNib:[UINib nibWithNibName:searchResultCellResuableStr bundle:nil] forCellWithReuseIdentifier:searchResultCellResuableStr];
        [_searchResultCollectionView registerNib:[UINib nibWithNibName:searchResultHeaderResuableStr bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:searchResultHeaderResuableStr];
        [_searchResultCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:searchResultFooterResuableStr];
        
        _searchResultCollectionView.opaque = YES;
        _searchResultCollectionView.backgroundColor = [UIColor whiteColor];
        _searchResultCollectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _searchResultCollectionView;
}

- (UICollectionView *)searchRecordCollectionView{
    
    if (!_searchRecordCollectionView) {
        WaterLayout *waterLayout = [WaterLayout new];
        waterLayout.rowMargin = 0;
        waterLayout.columnMargin = 0;
        waterLayout.columnsCount = 1;
        waterLayout.sectionEdgeInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        [waterLayout setHeaderSizeBlock:^CGSize(NSIndexPath *indexPath) {
            return CGSizeMake(ISScreen_Width, 0);
        }];
        
        [waterLayout setFooterSizeBlock:^CGSize(NSIndexPath *indexPath) {
            return CGSizeMake(ISScreen_Width, 65);
        }];
        
        [waterLayout setItemHeightBlock:^CGFloat(NSIndexPath *indexPath, CGFloat width) {
            return 44;
        }];
        
        _searchRecordCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, ISScreen_Width, ISScreen_Height) collectionViewLayout:waterLayout];
        _searchRecordCollectionView.delegate = self;
        _searchRecordCollectionView.dataSource = self;
        
        [_searchRecordCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:searchRecordHeaderResuabelStr];
        [_searchRecordCollectionView registerNib:[UINib nibWithNibName:searchRecordCellResuableStr bundle:nil] forCellWithReuseIdentifier:searchRecordCellResuableStr];
        [_searchRecordCollectionView registerNib:[UINib nibWithNibName:searchRecordFooterResuableStr bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:searchRecordFooterResuableStr];
        
        _searchRecordCollectionView.opaque = YES;
        _searchRecordCollectionView.backgroundColor = ColorFromRGB(0x2E2E3A, 0.8);
    }
    return _searchRecordCollectionView;
}

- (NSMutableArray *)searchRecordMuArray{
    LAZYINITMUARRAY(_searchRecordMuArray)
}

- (NSMutableArray *)searchResultMuArray{
    LAZYINITMUARRAY(_searchResultMuArray)
}

@end
