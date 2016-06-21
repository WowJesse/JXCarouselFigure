//
//  JXCarouselFigure.m
//  JXCarouselFigure
//
//  Created by jesse on 16/6/20.
//  Copyright © 2016年 jesse. All rights reserved.
//

#import "JXCarouselFigure.h"
#import "JXCarouselFigureCell.h"
#import "UIImageView+WebCache.h"

@interface JXCarouselFigure ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSTimer *_timer;
    NSUInteger _curruntIndex;
    UICollectionViewFlowLayout *_flowLayout;
    NSUInteger _totolImagesCount;
}
@property (nonatomic,strong) NSString *placeholderImage;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIPageControl *pageControl;
@end

@implementation JXCarouselFigure

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initialization];
        [self setupUI];
    }
    return self;
}
- (void)initialization
{
    self.autoScrollTimeInterval = 2.f;
    self.autoScroll = YES;
    self.infiniteLoop = YES;
    self.pageContolAliment = JXCycleScrollViewPageContolAlimentCenter;
}
- (void)setupUI
{
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
}
#pragma mark - 便捷构造
+(instancetype)figureWithFrame:(CGRect)frame andPlaceholderImage:(NSString *)placeholderImage
{
    JXCarouselFigure *figure = [[JXCarouselFigure alloc] initWithFrame:frame];
    figure.placeholderImage = placeholderImage;
    return figure;
}
#pragma mark - property setter
-(void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval
{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    
    //重新调一下 使其生效
    [self setAutoScroll:self.autoScroll];
}
-(void)setAutoScroll:(BOOL)autoScroll
{
    _autoScroll = autoScroll;
    [_timer invalidate];
    _timer = nil;
    
    if (_autoScroll) {
        [self setupTimer];
    }
}
-(void)setImageUrls:(NSArray *)imageUrls
{
    _imageUrls = imageUrls;
    
    _totolImagesCount = self.infiniteLoop ? imageUrls.count * 100 : imageUrls.count;
    
    [self refreshPageControlData];
}
-(void)setInfiniteLoop:(BOOL)infiniteLoop
{
    _infiniteLoop = infiniteLoop;
    //重新调一下 设置图片数组的方法 为了重新设置 _totolImagesCount 的大小 使其生效
    if (self.imageUrls) {
        self.imageUrls = self.imageUrls;
    }
}
-(void)setShowPageControl:(BOOL)showPageControl
{
    _showPageControl = showPageControl;
    
    self.pageControl.hidden = !_showPageControl;
}
-(void)setPageContolAliment:(JXCycleScrollViewPageContolAliment)pageContolAliment
{
    _pageContolAliment = pageContolAliment;
    
    [self refreshPageControlData];
}
#pragma mark - func
- (void)setupTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
- (void)automaticScroll
{
    if (_totolImagesCount == 0) return;
    NSUInteger currentIndex = _collectionView.contentOffset.x / _flowLayout.itemSize.width;
    NSUInteger nextIndex = currentIndex + 1;
    self.pageControl.currentPage = nextIndex % self.imageUrls.count;
    if (nextIndex == _totolImagesCount) {
        if (self.infiniteLoop) {
            [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
        return;
    }
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}
- (void)refreshPageControlData
{
    self.pageControl.numberOfPages = self.imageUrls.count;
    CGFloat pageControlWidth = 20 * self.imageUrls.count;
    self.pageControl.frame = CGRectMake(0, 0, pageControlWidth, 15);
    if (self.pageContolAliment == JXCycleScrollViewPageContolAlimentCenter) {
        self.pageControl.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height - 15);
    } else if (self.pageContolAliment == JXCycleScrollViewPageContolAlimentLeft) {
        self.pageControl.center = CGPointMake(pageControlWidth * 0.5 + 15, self.bounds.size.height - 15);
    } else if (self.pageContolAliment == JXCycleScrollViewPageContolAlimentRight) {
        self.pageControl.center = CGPointMake(self.bounds.size.width - pageControlWidth * 0.5 - 15, self.bounds.size.height - 15);
    }

}
+(void)clearCache
{
    [[[SDWebImageManager sharedManager] imageCache] clearDisk];
}
#pragma mark - 懒加载
-(UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = self.bounds.size;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout = flowLayout;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        [_collectionView registerClass:[JXCarouselFigureCell class] forCellWithReuseIdentifier:@"JXCarouselFigureCell"];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}
-(UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        [self refreshPageControlData];
    }
    return _pageControl;
}
#pragma mark - collectionView datasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //无图片数组时 显示占位图
    if (_totolImagesCount == 0) {
        [self setImageUrls:@[self.placeholderImage?:@""]];
    }
    return _totolImagesCount;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JXCarouselFigureCell *cell = [JXCarouselFigureCell collectionViewWith:collectionView andReuseIdentifier:@"JXCarouselFigureCell" andIndexPath:indexPath andPlaceholderImage:self.placeholderImage];
    [cell addImageWith:self.imageUrls[indexPath.item % self.imageUrls.count]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.clickItemBlock) {
        self.clickItemBlock(indexPath.item % self.imageUrls.count);
    }
}
#pragma mark - uiscrollview delegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.autoScroll) {
        [self setupTimer];
    }
}
@end
