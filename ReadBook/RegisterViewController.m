//
//  RegisterViewController.m
//  ReadBook
//
//  Created by 吴其涛 on 15/9/11.
//  Copyright (c) 2015年 wuqitao. All rights reserved.
//

#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "Header.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userID;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)registerID:(id)sender {
    //获取appDelegate的代理
    AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
    //获取托管对象上下文
    NSManagedObjectContext * context = [appDelegate managedObjectContext];
    //接收错误信息
    NSError * error;
    //建立查询请求
    NSFetchRequest * request = [[NSFetchRequest alloc]initWithEntityName:KLineEntityName];
     //设置查询条件 根据用户输入的用户名来查找
    NSPredicate * pre = [NSPredicate predicateWithFormat:@"%K = %@",user_name,self.userID.text];
    //加入查询条件
    [request setPredicate:pre];
    //获取数据
    NSArray * objects = [context executeFetchRequest:request error:&error];
    //如果数组没有建立起来
    if (objects==nil) {
        NSLog(@"111111");
    }
    NSManagedObject * theUser = nil;
    //创建操作表
    UIAlertController * controller = [UIAlertController alertControllerWithTitle:@"请选择操作" message:nil preferredStyle:UIAlertControllerStyleAlert];
     //说明有数据 则用户名重复
    if ([objects count]>0) {
        //创建操作
        UIAlertAction * alertAction = [UIAlertAction actionWithTitle:@"用户名重复" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
           
            self.userID.text = @"";
            self.password.text = @"";
            
        }];
        //加入操作表
        [controller addAction:alertAction];
        //显示操作表
        [self presentViewController:controller animated:YES completion:nil];
        return;
    }else{
        //初始化
        theUser = [NSEntityDescription insertNewObjectForEntityForName:KLineEntityName inManagedObjectContext:context];
    }
    //将用户输入的用户名和密码存储
    [theUser setValue:self.userID.text forKey:user_name];
    [theUser setValue:self.password.text forKey:user_password];
    
    //创建操作表 提示注册成功进入登录界面
    UIAlertAction * alertAction = [UIAlertAction actionWithTitle:@"注册成功进入登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        self.userID.text = @"";
        self.password.text = @"";
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    //创建操作表 提示不想返回登录界面 可以选择留在此界面
    UIAlertAction * alertAction1 = [UIAlertAction actionWithTitle:@"留在此页面" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        self.userID.text = @"";
        self.password.text = @"";
        
    }];
    //加入操作表
    [controller addAction:alertAction1];
    [controller addAction:alertAction];
    //显示操作表
    [self presentViewController:controller animated:YES completion:nil];
    //存储
    [appDelegate saveContext];
}

- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
