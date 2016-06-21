//
//  JXCarouselFigureCell.h
//  JXCarouselFigure
//
//  Created by jesse on 16/6/20.
//  Copyright © 2016年 jesse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXCarouselFigureCell : UICollectionViewCell
+(instancetype)collectionViewWith:(UICollectionView *)collectionView andReuseIdentifier:(NSString *)reuseIdentifier andIndexPath:(NSIndexPath *)indexPath andPlaceholderImage:(NSString *)image;

- (void)addImageWith:(NSString *)imageStr;
@end
