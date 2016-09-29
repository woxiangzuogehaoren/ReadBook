//
//  collectionViewLayout.m
//  ReadBook
//
//  Created by 吴其涛 on 15/9/7.
//  Copyright (c) 2015年 wuqitao. All rights reserved.
//

#import "collectionViewLayout.h"
#import "CollectionReusableView.h"
@implementation collectionViewLayout

//自动调用 初始化
-(void)prepareLayout{
    
    [super prepareLayout];
    
    [self registerClass:[CollectionReusableView class] forDecorationViewOfKind:@"Layout"];//注册Decoration View
    
}
-(CGSize)collectionViewContentSize{
    
    return self.collectionView.frame.size;
    
}
//设置单元格的方法
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path

{
    //创建并返回一个布局属性对象，它表示指定索引路径的单元格
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    //设置Cell的大小
    attributes.size = CGSizeMake(100 ,100);
    //cell的中心点坐标
    attributes.center=CGPointMake(95*(path.item+1), 62.5+125*path.section);
    
    return attributes;
    
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)decorationViewKind atIndexPath:(NSIndexPath *)indexPath{
    
    
    //创建并返回一个布局属性对象，表示指定的装修视图
    UICollectionViewLayoutAttributes* att = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewKind withIndexPath:indexPath];
    
    att.frame=CGRectMake(0, (125*indexPath.section)/2.0, self.collectionView.frame.size.width, 125);
    
    att.zIndex=-1;
    
    return att;
    
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray* attributes = [NSMutableArray array];
    
    //把Decoration View的布局加入可见区域布局。
    //图片显示多少节
    for (int y=0; y<5; y++) {
        
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:5 inSection:y];
        //将背景图片设置加入数组 集合视图有多少节就加入多少
        [attributes addObject:[self layoutAttributesForDecorationViewOfKind:@"Layout"atIndexPath:indexPath]];
    }
    
    
    //Cell显示多少节毎节多少个
    for (NSInteger i=0 ; i < 5; i++) {
        
        for (NSInteger t=0; t<3; t++) {
            
            NSIndexPath* indexPath = [NSIndexPath indexPathForItem:t inSection:i];
            
            [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
            
        }
        
    }
    
    
    return attributes;
    
}
@end
