//
//  ViewController.m
//  JXCarouselFigure
//
//  Created by 张明辉 on 16/6/20.
//  Copyright © 2016年 jesse. All rights reserved.
//

#import "ViewController.h"
#import "JXCarouselFigure.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    JXCarouselFigure *figure = [JXCarouselFigure figureWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 300) andPlaceholderImage:@"http://pic.cn2che.com/pics/2012-03/29/201203291058165950.jpg"];
    figure.imageUrls = @[@"http://pic.cn2che.com/pics/2012-03/29/201203291058165950.jpg",@"http://h.hiphotos.baidu.com/image/h%3D200/sign=616fef1a9b510fb367197097e932c893/a8014c086e061d958dd9969b7ef40ad163d9caf2.jpg",@"http://c.hiphotos.baidu.com/image/pic/item/f7246b600c3387448982f948540fd9f9d72aa0bb.jpg"];
    figure.autoScrollTimeInterval = 2;
    figure.clickItemBlock = ^(NSInteger index){
        //点击轮播图
    };
    [self.view addSubview:figure];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
