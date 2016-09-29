//
//  MoreViewController.m
//  ReadBook
//
//  Created by 吴其涛 on 15/9/10.
//  Copyright (c) 2015年 wuqitao. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation MoreViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    self.textView.editable = NO;
    self.textView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];
    //读出小说
    NSString * path = [[NSBundle mainBundle]pathForResource:self.name ofType:@"rtf"];
    //将小说转换成字符串
    NSString *contentString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    self.textView.text = contentString;
}



- (void) viewWillDisappear:(BOOL)paramAnimated{
    
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
