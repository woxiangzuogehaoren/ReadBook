//
//  CollectionReusableView.m
//  ReadBook
//
//  Created by 吴其涛 on 15/9/7.
//  Copyright (c) 2015年 wuqitao. All rights reserved.
//

#import "CollectionReusableView.h"

@implementation CollectionReusableView
//初始化集合视图每一节的背景图片
- (id)initWithFrame:(CGRect)frame

{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:frame];
        
        imageView.image=[UIImage imageNamed:@"BookShelfCell.png"];
        
        
        
        [self addSubview:imageView];
        
    }
    
    return self;
    
}
@end
