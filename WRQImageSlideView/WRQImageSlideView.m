//
//  WRQImageSlideView.m
//  图片轮播器
//
//  Created by Apple on 2017/5/10.
//  Copyright © 2017年 WRQ. All rights reserved.
//

#import "WRQImageSlideView.h"

@implementation WRQImageSlideView

- (instancetype)initWithFrame:(CGRect)frame
                 TimeInterval:(NSTimeInterval)timeInterval
                       Images:(NSArray *)images
                         Urls:(NSArray *)urls
                     Observer:(NSObject *)observer{
    self = [super initWithFrame:frame];
    if (self) {
        _imageArray = images;
        _urlArray = urls;
        _timeInterval = timeInterval;
        [self initCollectionViewWithFrame:frame Images:images];
        [self initpageControlWithFrame:frame];
        [self initNSTimerWithTimeInterval:timeInterval];
        [self addObserver:observer forKeyPath:@"urlString" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

#pragma mark - 创建scrollerVIew
- (void)initCollectionViewWithFrame:(CGRect)frame
                         Images:(NSArray *)images{
    //创建collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(frame.size.width, frame.size.height);
    layout.minimumLineSpacing = 0;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor clearColor];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self addSubview:collectionView];
    
    _collectionView = collectionView;
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:_imageArray[indexPath.row]];
    imageView.bounds = CGRectMake(0, 0, collectionView.bounds.size.width, collectionView.bounds.size.height);
    cell.backgroundView = imageView;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.urlString = _urlArray[indexPath.row];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = _collectionView.contentOffset.x + self.bounds.size.width * 0.5;
    long page = offset/self.bounds.size.width;
    _pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self initNSTimerWithTimeInterval:_timeInterval];
}

#pragma mark - 添加pageControl
- (void)initpageControlWithFrame:(CGRect)frame{
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.frame = CGRectMake((frame.size.width-100)/2, frame.size.height * 0.8, 100, 50);
    pageControl.numberOfPages = _imageArray.count;
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.92 green:0.30 blue:0.24 alpha:1.00];
    [self addSubview:pageControl];
    _pageControl = pageControl;
}


#pragma mark - 添加timer
- (void)initNSTimerWithTimeInterval:(NSTimeInterval)timeInterval{
    _timer = [NSTimer timerWithTimeInterval:timeInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
        long page = _pageControl.currentPage;
        if (page == _imageArray.count - 1) {
            page = 0;
        }
        else{
            page ++;
        }
        [_collectionView setContentOffset:CGPointMake(page * self.bounds.size.width, 0) animated:YES];
    }];
    
    //启动timer
    [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}

@end
