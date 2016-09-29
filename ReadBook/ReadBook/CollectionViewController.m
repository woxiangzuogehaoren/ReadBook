//
//  CollectionViewController.m
//  ReadBook
//
//  Created by 吴其涛 on 15/9/7.
//  Copyright (c) 2015年 wuqitao. All rights reserved.
//

#import "CollectionViewController.h"
#import "collectionViewLayout.h"
#import "CollectionViewCell.h"
#import "TableViewController.h"
#import "Header.h"
#import "EnterViewController.h"
#import "UserInfoViewController.h"
#import "UserHelpViewController.h"
#import "CollectTableViewController.h"
#import "AboutUsViewController.h"
#import "MoreViewController.h"
#import "WebViewController.h"

@interface CollectionViewController ()

@property (strong, nonatomic) UITableView *settingTableView;
@property (strong, nonatomic) TableViewController* setTableView;


@property (strong, nonatomic) UIButton *searchButton;
@property (strong, nonatomic) UIButton *moveButton;

@property (strong,nonatomic) NSArray * novel;
@property (strong,nonatomic) NSMutableDictionary * novelDict;
@end

//设置静态属性

static BOOL isSeetingButtonClicked = YES;

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // self.clearsSelectionOnViewWillAppear = NO;
    //读出数据
    NSString * path = [[NSBundle mainBundle]pathForResource:@"novel" ofType:@"plist"];
    //接收数据
    self.novel = [NSArray arrayWithContentsOfFile:path];
    
    
    //注册cell
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //初始化layout
    collectionViewLayout * layout = [[collectionViewLayout alloc]init];
    //根据layout设置集合视图
    [self.collectionView setCollectionViewLayout:layout];
    //视图背景
    self.collectionView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"launchScreen"]];
    //调用设置导航条的方法
    [self settingNavigationBar];
    //调用弹出左侧页面的方法
    [self getTableView];
    //设置返回按钮
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = returnButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)settingNavigationBar{
    //标题
    self.navigationItem.title = @"ReadBook";
    //导航栏背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar2"] forBarMetrics:UIBarMetricsDefault];
    //左按钮
    self.leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //大小位置
    self.leftButton.frame = CGRectMake(0, 0, 30, 30);
    //背景图片
    UIImage *leftNomal = [UIImage imageNamed:@"profle"];
    [self.leftButton setBackgroundImage:leftNomal forState:UIControlStateNormal];
    //设置监听方法
    [self.leftButton addTarget:self action:@selector(inputTableView) forControlEvents:UIControlEventTouchUpInside];
    //加入导航
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftButton];
    
    
    self.searchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.searchButton.frame = CGRectMake(0, 0, 30, 30);
    UIImage * searchNomal = [UIImage imageNamed:@"search"];
    [self.searchButton setBackgroundImage:searchNomal forState:UIControlStateNormal];
    [self.searchButton addTarget:self action:@selector(websearch) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * searchButton = [[UIBarButtonItem alloc]initWithCustomView:self.searchButton];
    
    self.moveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.moveButton.frame = CGRectMake(0, 0, 30, 30);
    UIImage * webNomal = [UIImage imageNamed:@"net-vibes"];
    [self.moveButton setBackgroundImage:webNomal forState:UIControlStateNormal];
    [self.moveButton addTarget:self action:@selector(no) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * moveButton = [[UIBarButtonItem alloc]initWithCustomView:self.moveButton];
    self.navigationItem.rightBarButtonItems = @[moveButton,searchButton];
    

}
//点击按钮是推出web页面
-(void)websearch{
    //得到故事板
    UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //从故事版中取出视图
    WebViewController * webViewControll = [story instantiateViewControllerWithIdentifier:webView];
    //推出下一页面
    [self.navigationController pushViewController:webViewControll animated:YES];
    
    
}
//设按钮的方法
-(void)no
{   //该功能没有实现
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"⚠️" message:@"该功能暂未实现" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alert show];

}
#pragma 设置左侧按钮和左侧弹出的视图
-(void)inputTableView{
    
    if (isSeetingButtonClicked) {
        //在弹出左侧页面是进行监听
        [self acceptedMessage];
        //加入动画
        [UIView animateWithDuration:0.5 animations:^{
         //从左边弹出
        _settingTableView.frame = CGRectMake(0, 0, self.view.frame.size.width-100, self.view.frame.size.height);
        }];
        //标示位设为NO
        isSeetingButtonClicked = NO;
    }else{
        //收回
        [UIView animateWithDuration:0.5 animations:^{
            _settingTableView.frame = CGRectMake(-self.view.frame.size.width-100, 0, self.view.frame.size.width-100, self.view.frame.size.height);
        }];
        //标示位设为YES
        isSeetingButtonClicked = YES;
    }

}
//得到左侧视图
-(void)getTableView{
    //新建一个tableView并设置初始位置和大小
    self.settingTableView = [[UITableView alloc]initWithFrame:CGRectMake(-self.view.frame.size.width-100, 0, self.view.frame.size.width-100, self.view.frame.size.height) style:UITableViewStyleGrouped];
    //设置背景颜色
    self.settingTableView.backgroundColor = [[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0.5];
    [self.collectionView addSubview:_settingTableView];
    //初始化setTableView
    self.setTableView = [[TableViewController alloc]init];
    //设置代理
    self.settingTableView.dataSource = self.setTableView;
    self.settingTableView.delegate = self.setTableView;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return self.novel.count/3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    self.novelDict = self.novel[indexPath.section*3+indexPath.row];
    cell.backgroundView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",self.novelDict[@"name"]]]];
    
    return cell;
    
    // Configure the cell
    
}

//接收点击单元发出消息
-(void)acceptedMessage{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(nextPage:) name:enter object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(nextPage:) name:userInformation object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(nextPage:) name:userHelp object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(nextPage:) name:userCollections object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(nextPage:) name:aboutUs object:nil];
    
    
}
//-(void)nextPage1{
//    
//    UIStoryboard * storyBord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    EnterViewController * enterView = [storyBord instantiateViewControllerWithIdentifier:enter];
//    
//    [self.navigationController pushViewController:enterView animated:YES];
//
//    
//    
//}
-(void)nextPage:(NSNotification*)notification{
     UIStoryboard * storyBord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //根据监听的名字来判断是哪个一个单元发出的消息
    if ([notification.name isEqualToString:enter]) {
        NSLog(@"enter");
       
        EnterViewController * enterView = [storyBord instantiateViewControllerWithIdentifier:enter];
        [self presentViewController:enterView animated:YES completion:^{
            
            
        }];
        //[self.navigationController pushViewController:enterView animated:YES];
        //移除监听,以免造成多次监听
        [[NSNotificationCenter defaultCenter]removeObserver:self name:enter object:nil];
    }else if ([notification.name isEqualToString:userInformation]) {
        
        NSLog(@"userInformation");
        UserInfoViewController * userInformationView = [storyBord instantiateViewControllerWithIdentifier:userInformation];
        
        [self.navigationController pushViewController:userInformationView animated:YES];
        
        [[NSNotificationCenter defaultCenter]removeObserver:self name:userInformation object:nil];
    }
    else if ([notification.name isEqualToString:userHelp]) {
        NSLog(@"userHelp");
        UserHelpViewController * userHelpView = [storyBord instantiateViewControllerWithIdentifier:userHelp];
        
        [self.navigationController pushViewController:userHelpView animated:YES];
        
        [[NSNotificationCenter defaultCenter]removeObserver:self name:userHelp object:nil];
    }
    else if ([notification.name isEqualToString:userCollections]) {
        NSLog(@"userCollections");
        CollectTableViewController * collectionsView = [storyBord instantiateViewControllerWithIdentifier:userCollections];
        
        [self.navigationController pushViewController:collectionsView animated:YES];
        
        [[NSNotificationCenter defaultCenter]removeObserver:self name:userCollections object:nil];
    }
    else if ([notification.name isEqualToString:aboutUs]) {
        NSLog(@"aboutUs");
        AboutUsViewController * aboutUsView = [storyBord instantiateViewControllerWithIdentifier:aboutUs];
        
        [self.navigationController pushViewController:aboutUsView animated:YES];
        
        [[NSNotificationCenter defaultCenter]removeObserver:self name:aboutUs object:nil];
    }
    //收回左侧视图
    [UIView animateWithDuration:0.5 animations:^{
        _settingTableView.frame = CGRectMake(-self.view.frame.size.width-100, 0, self.view.frame.size.width-100, self.view.frame.size.height);
    }];
    //标示为设为YES
    isSeetingButtonClicked = YES;
}

#pragma mark <UICollectionViewDelegate>
//点击Cell时调用
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   //根据点击的那一节来判断
    switch (indexPath.section) {
        case 0:
            //那一节的那一个单元格来判断 读出那一本小说
            switch (indexPath.row) {
                case 0:
                    [self readBook:indexPath.section*3 +indexPath.row];
                    break;
                case 1:
                    [self readBook:indexPath.section*3 +indexPath.row];
                    break;
                case 2:
                    [self readBook:indexPath.section*3 +indexPath.row];
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    [self readBook:indexPath.section*3 +indexPath.row];
                    break;
                case 1:
                    [self readBook:indexPath.section*3 +indexPath.row];
                    break;
                case 2:
                    [self readBook:indexPath.section*3 +indexPath.row];
                    break;
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                    [self readBook:indexPath.section*3 +indexPath.row];
                    break;
                case 1:
                    [self readBook:indexPath.section*3 +indexPath.row];
                    break;
                case 2:
                    [self readBook:indexPath.section*3 +indexPath.row];
                    break;
                default:
                    break;
            }
            break;
        case 3:
            switch (indexPath.row) {
                case 0:
                    [self readBook:indexPath.section*3 +indexPath.row];
                    break;
                case 1:
                    [self readBook:indexPath.section*3 +indexPath.row];
                    break;
                case 2:
                    [self readBook:indexPath.section*3 +indexPath.row];
                    break;
                default:
                    break;
            }
            break;
        case 4:
            switch (indexPath.row) {
                case 0:
                    [self readBook:indexPath.section*3 +indexPath.row];
                    break;
                case 1:
                    [self readBook:indexPath.section*3 +indexPath.row];
                    break;
                case 2:
                    [self readBook:indexPath.section*3 +indexPath.row];
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
   
}
//读书的方法
-(void)readBook:(NSInteger)indexPath{
    //初始化
    UIStoryboard * storyBord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //从故事版获得视图
    MoreViewController * moreViewControll = [storyBord instantiateViewControllerWithIdentifier:moreView];
    //推出视图
    [self.navigationController pushViewController:moreViewControll animated:YES];
    //根据点击Cell为数组下标 获取数组中的自点
    self.novelDict = self.novel[indexPath];
    //获取小说名
    moreViewControll.name = self.novelDict[@"name"];
    //根据小说名设置标题
    moreViewControll.title = self.novelDict[@"name"];
    
}
@end
