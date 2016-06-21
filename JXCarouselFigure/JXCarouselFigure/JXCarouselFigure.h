//
//  JXCarouselFigure.h
//  JXCarouselFigure
//
//  Created by jesse on 16/6/20.
//  Copyright © 2016年 jesse. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    JXCycleScrollViewPageContolAlimentLeft,
    JXCycleScrollViewPageContolAlimentRight,
    JXCycleScrollViewPageContolAlimentCenter
} JXCycleScrollViewPageContolAliment;

@interface JXCarouselFigure : UIView
/**
 *  初始化轮播器
 */
+ (instancetype)figureWithFrame:(CGRect)frame andPlaceholderImage:(NSString *)placeholderImage;
/**
 *  是否自动滚动
 */
@property (nonatomic) BOOL autoScroll;
/**
 *  自动滚动时间间隔
 */
@property (nonatomic) CGFloat autoScrollTimeInterval;
/**
 *  是否无限循环（默认为yes）
 */
@property(nonatomic,assign) BOOL infiniteLoop;
/**
 *  图片数组（支持本地图片、网络图片）
 */
@property (nonatomic,strong) NSArray *imageUrls;
/**
 *  点击图片block
 */
@property (nonatomic,strong) void (^clickItemBlock) (NSInteger index);
/**
 *  是否显示pagecontrol
 */
@property (nonatomic) BOOL showPageControl;
/**
 *  pagecontrol显示位置
 */
@property (nonatomic) JXCycleScrollViewPageContolAliment pageContolAliment;
/**
 *  清除缓存
 */
+ (void)clearCache;
@end
