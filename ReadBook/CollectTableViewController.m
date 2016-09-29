//
//  CollectTableViewController.m
//  ReadBook
//
//  Created by 吴其涛 on 15/9/10.
//  Copyright (c) 2015年 wuqitao. All rights reserved.
//

#import "CollectTableViewController.h"
#import "NovelInfoViewController.h"
#import "Header.h"
@interface CollectTableViewController ()
@property (strong,nonatomic)NSArray * novel;
@property (strong,nonatomic)NSMutableDictionary * info;
@property (strong,nonatomic)NovelInfoViewController * novelControll;
@property (assign,nonatomic)NSInteger index;
@end
static NSString * Identifier = @"Cell";
@implementation CollectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //读取plist文件
    NSString * path = [[NSBundle mainBundle]pathForResource:@"novel" ofType:@"plist"];
    //接收数据
    self.novel = [NSArray arrayWithContentsOfFile:path];
    
//    self.novelControll = [[NovelInfoViewController alloc]init];
//    self.novelControll.novelInfo = self.novel[self.index];
//    self.novelControll.novelInfo = self.novel;
//    NSLog(@"%@",self.novelControll.novelInfo);
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
    return [self.novel count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    
    self.info = self.novel[indexPath.row];
    cell.textLabel.text = self.info[@"name"];
    cell.detailTextLabel.text = [self.info valueForKey:@"author"];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//将数据传到下一级
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:identifierInfo]) {
        //要推出谁 目标
        self.novelControll = segue.destinationViewController;
        
        //判断选中了哪一组那一个单元格
        self.index = [[self.tableView indexPathForSelectedRow]row];
        
        //用下一级数组接收数据
        self.novelControll.novelInfo = self.novel;
        //接收选中了哪一组那一个单元格作为数组的下标
        self.novelControll.index = self.index;
        self.info = self.novel[self.index];
        //导航条名字 根据选择的单元格类容来定
        self.novelControll.title = [self.info valueForKey:@"name"];
    }
    
    
}


@end
