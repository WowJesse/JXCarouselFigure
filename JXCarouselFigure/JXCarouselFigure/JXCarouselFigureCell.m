//
//  JXCarouselFigureCell.m
//  JXCarouselFigure
//
//  Created by jesse on 16/6/20.
//  Copyright © 2016年 jesse. All rights reserved.
//

#import "JXCarouselFigureCell.h"
#import "UIImageView+WebCache.h"
@interface JXCarouselFigureCell ()
@property (nonatomic,strong) NSString *placeholderImage;
@property (nonatomic,strong) UIImageView *showImageView;
@end

@implementation JXCarouselFigureCell
+(instancetype)collectionViewWith:(UICollectionView *)collectionView andReuseIdentifier:(NSString *)reuseIdentifier andIndexPath:(NSIndexPath *)indexPath andPlaceholderImage:(NSString *)image
{
    JXCarouselFigureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (cell.showImageView == nil) {
        cell.showImageView = [[UIImageView alloc] init];
        cell.showImageView.frame = cell.contentView.bounds;
        [cell.contentView addSubview:cell.showImageView];
    }
    //添加占位图
    [cell addImageWith:image];
    return cell;
}
- (void)addImageWith:(NSString *)imageStr
{
    if (!imageStr) {
        return;
    }
    if ([imageStr isKindOfClass:[NSString class]]) {
        if ([imageStr hasPrefix:@"http"]) {
            [self.showImageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
        } else {
            self.showImageView.image = [UIImage imageNamed:imageStr];
        }
    }
}
@end
