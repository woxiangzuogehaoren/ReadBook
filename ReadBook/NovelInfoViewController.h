//
//  NovelInfoViewController.h
//  ReadBook
//
//  Created by 吴其涛 on 15/9/10.
//  Copyright (c) 2015年 wuqitao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NovelInfoViewController : UIViewController
//用来接收上一级页面传入的数据
@property (strong,nonatomic)NSArray * novelInfo;
@property (assign,nonatomic)NSInteger index;
@end
