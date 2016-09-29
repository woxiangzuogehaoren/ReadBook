//
//  WebViewController.m
//  ReadBook
//
//  Created by 吴其涛 on 15/9/11.
//  Copyright (c) 2015年 wuqitao. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL * url = [NSURL URLWithString:@"http://www.qidian.com/Default.aspx"];
    //建立网络请求的对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //把网络请求的对象加载到webView
    [self.webView loadRequest:request];
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
