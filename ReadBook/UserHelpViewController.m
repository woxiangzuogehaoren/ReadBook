//
//  UserHelpViewController.m
//  ReadBook
//
//  Created by 吴其涛 on 15/9/10.
//  Copyright (c) 2015年 wuqitao. All rights reserved.
//

#import "UserHelpViewController.h"

@interface UserHelpViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation UserHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //textView不可编辑状态
    self.textView.editable = NO;
    //设置背景
    self.textView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];
    // Do any additional setup after loading the view.
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
