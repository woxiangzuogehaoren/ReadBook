//
//  BookViewController.m
//  ReadBook
//
//  Created by 吴其涛 on 15/9/11.
//  Copyright (c) 2015年 wuqitao. All rights reserved.
//

#import "BookViewController.h"

@interface BookViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.editable = NO;
    self.textView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];
    //读出小说
    //将小说转换成字符串
    NSString * path = [[NSBundle mainBundle]pathForResource:self.name ofType:@"rtf"];
    
    NSString *contentString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    self.textView.text = contentString;
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
