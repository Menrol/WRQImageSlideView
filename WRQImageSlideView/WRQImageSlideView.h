//
//  WRQImageSlideView.h
//  图片轮播器
//
//  Created by Apple on 2017/5/10.
//  Copyright © 2017年 WRQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WRQImageSlideView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
{
    //collectionView
    UICollectionView *_collectionView;
    //pageControl
    UIPageControl *_pageControl;
    //图片数组
    NSArray *_imageArray;
    //URL数组
    NSArray *_urlArray;
    //定时器
    NSTimer *_timer;
    //时间间隔
    NSTimeInterval _timeInterval;
}

/** URLString */
@property(nonatomic, copy) NSString *urlString;

- (instancetype)initWithFrame:(CGRect)frame
                 TimeInterval:(NSTimeInterval)timeInterval
                       Images:(NSArray *)images
                         Urls:(NSArray *)urls
                     Observer:(NSObject *)observer;
@end
