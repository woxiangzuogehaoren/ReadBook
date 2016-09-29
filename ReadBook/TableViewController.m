//
//  TableViewController.m
//  ReadBook
//
//  Created by 吴其涛 on 15/9/8.
//  Copyright (c) 2015年 wuqitao. All rights reserved.
//

#import "TableViewController.h"

#import "Header.h"
@interface TableViewController ()

@end
static NSString *identifier =  @"Cell";
@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.tableView.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0.5];
    cell.textLabel.textColor = [UIColor whiteColor];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"登录";
            cell.imageView.image = [UIImage imageNamed:@"members"];
            break;
        case 1:
            cell.textLabel.text = @"用户须知";
            cell.imageView.image = [UIImage imageNamed:@"usercenter"];
            break;
        case 2:
            cell.textLabel.text = @"用户帮助";
            cell.imageView.image = [UIImage imageNamed:@"male-user-help"];
            break;
        case 3:
            cell.textLabel.text = @"用户收藏";
            cell.imageView.image = [UIImage imageNamed:@"info"];
            break;
        case 4:
            cell.textLabel.text = @"关于我们";
            cell.imageView.image = [UIImage imageNamed:@"contacts"];
            break;
        default:
            break;
    }
    return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"更多";
    
}
-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    
    return @"娱乐为主,请勿吐槽!";
}
//当点击单元格时,让他发出消息
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
           [[NSNotificationCenter defaultCenter]postNotificationName:enter object:nil];
            break;
        case 1:
            [[NSNotificationCenter defaultCenter]postNotificationName:userInformation object:nil];
            break;
        case 2:
            [[NSNotificationCenter defaultCenter]postNotificationName:userHelp object:nil];
            break;
        case 3:
           [[NSNotificationCenter defaultCenter]postNotificationName:userCollections object:nil];
            break;
        case 4:
            [[NSNotificationCenter defaultCenter]postNotificationName:aboutUs object:nil];
            break;
        default:
            break;
    }
    
    
}

#pragma mark - Navigation





@end
