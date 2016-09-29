//
//  NovelInfoViewController.m
//  ReadBook
//
//  Created by 吴其涛 on 15/9/10.
//  Copyright (c) 2015年 wuqitao. All rights reserved.
//

#import "NovelInfoViewController.h"
#import "BookViewController.h"
@interface NovelInfoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *novelName;
@property (weak, nonatomic) IBOutlet UILabel *outhor;
@property (weak, nonatomic) IBOutlet UIButton *readBook;
@property (weak, nonatomic) IBOutlet UIButton *contents;
@property (weak, nonatomic) IBOutlet UITextView *info;
@property (strong,nonatomic)NSMutableDictionary * novelDict;
@property (strong,nonatomic)BookViewController * book;
@end

@implementation NovelInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //不可编辑状态;
//    self.book = [BookViewController new];
   //设置背景
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];
    self.info.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];
    self.info.editable = NO;
    self.novelDict = [NSMutableDictionary dictionary];
    
    //取出数组里的字典
    _novelDict = _novelInfo[_index];
        
    _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",_novelDict[@"name"]]];
    _novelName.text = _novelDict[@"name"];
    _outhor.text = _novelDict[@"author"];
    _info.text = _novelDict[@"info"];
    self.book.name = _novelDict[@"name"];
    
}
- (IBAction)readBook:(id)sender {
    
    
//    UIStoryboard * storyBord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//    self.book = [storyBord instantiateViewControllerWithIdentifier:@"bookView"];
//    
//    [self.navigationController pushViewController:self.book animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //获取要推出的目标
    BookViewController * book = segue.destinationViewController;
    //取出小说名字
    book.name = _novelDict[@"name"];
    
}


@end
