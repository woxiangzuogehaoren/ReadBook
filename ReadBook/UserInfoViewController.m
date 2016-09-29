//
//  UserInfoViewController.m
//  ReadBook
//
//  Created by 吴其涛 on 15/9/10.
//  Copyright (c) 2015年 wuqitao. All rights reserved.
//

#import "UserInfoViewController.h"
#import "Header.h"
@interface UserInfoViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *page;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (strong,nonatomic)NSTimer *timer;
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //让textView处于不可编辑的状态
    self.textView.editable = NO;
    //设置背景
    self.textView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];
    //获取屏幕宽度
    CGFloat imageW = self.view.frame.size.width;
    //获取scrollView高度
    CGFloat imageH = self.scrollView.frame.size.height;
   
    CGFloat imageY = 0;
    for (int i = 0; i<Count; i++) {
        
        UIImageView *imageView = [UIImageView new];
        CGFloat imageX = i*imageW;
        //设置iamgeView的初始位置和大小
        imageView.frame = CGRectMake(imageX,imageY,imageW,imageH);
        
        NSString *name = [NSString stringWithFormat:@"img_%02d",i+1];
        //加入图片
        imageView.image = [UIImage imageNamed:name];
        //将iamgeView加到scrollView
        [_scrollView addSubview:imageView];
        
        
    }
    
    CGFloat contentW = Count*imageW;
    //设置contentSize
    _scrollView.contentSize = CGSizeMake(contentW, 0);
    NSLog(@"%f",_scrollView.contentSize.height);
    /*隐藏水平滚动条*/
    _scrollView.showsHorizontalScrollIndicator = NO;
    /*分页显示*/
    _scrollView.pagingEnabled = YES;
    
    /*页码控制器*/
    _page.numberOfPages = Count;
    [self addTimer];
    
}
-(void)addTimer
{
    //计时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}
-(void)removeTimer
{
    //终止计时器
    [_timer invalidate];
    _timer =nil;
}
-(void)nextImage
{
    
    int page = 0;
    if (_page.currentPage==Count-1) {
        page = 0;
    }else{
        page = (int)_page.currentPage+1;
    }
    
    /*计算scrollView滚动位置*/
    CGFloat offsetX = page*self.view.frame.size.width;
    CGPoint offset = CGPointMake(offsetX, 0);
    [_scrollView setContentOffset:offset animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat scrollW =self.scrollView.frame.size.width;
    int page = (_scrollView.contentOffset.x+scrollW*0.5)/scrollW;
    self.page.currentPage = page;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
