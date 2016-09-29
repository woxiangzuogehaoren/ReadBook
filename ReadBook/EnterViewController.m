//
//  EnterViewController.m
//  ReadBook
//
//  Created by 吴其涛 on 15/9/10.
//  Copyright (c) 2015年 wuqitao. All rights reserved.
//

#import "EnterViewController.h"
#import "RegisterViewController.h"
#import "CollectionViewController.h"
#import "Header.h"
#import "AppDelegate.h"
@interface EnterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *uesrName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (strong,nonatomic)CollectionViewController * collectionControll;
@end

@implementation EnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置view的背景图片
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"登录.jpg"]];
    //创建观察者 (registerCompletion:)有且只有一个参数 类型(NSNotification*)
    
    // Do any additional setup after loading the view.
//    UIBarButtonItem * back = [[UIBarButtonItem alloc]init];
//    back.title = @"back";
//    self.navigationItem.leftBarButtonItem =back;
}
//-(void)registerCompletion:(NSNotification*)notification{
//    //用字典接受监听到的消息传来的参数
//    NSDictionary *data = [notification userInfo];
//    NSString * username = data[@"username"];
//    
//    self.uesrName.text = username;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)enterNextPage:(id)sender {
    //获取appDelegate的代理
    AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
    //获取托管对象上下文
    NSManagedObjectContext * context = [appDelegate managedObjectContext];
    //接收错误信息
    NSError * error;
    //建立查询请求
    NSFetchRequest * request = [[NSFetchRequest alloc]initWithEntityName:KLineEntityName];
    //设置查询条件 根据用户输入的用户名来查找
    NSPredicate * pre = [NSPredicate predicateWithFormat:@"%K = %@",user_name,self.uesrName.text];
    //加入查询条件
    [request setPredicate:pre];
    //获取数据
    NSArray * objects = [context executeFetchRequest:request error:&error];
    //如果数组没有建立起来
    if (objects==nil) {
        NSLog(@"1111");
        abort();
    }
   
    //说明有数据
    if (objects.count>0) {
        
        for (NSManagedObject * oneObject in objects) {
            //根据用户输入的信息和从coreData数据
            if ([self.uesrName.text isEqualToString:[oneObject valueForKey:user_name]]&&[self.password.text isEqualToString:[oneObject valueForKey:user_password]]) {
                //创建操作表
                 UIAlertController * controller = [UIAlertController alertControllerWithTitle:@"请选择操作" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                //创建操作
                UIAlertAction * alertAction = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        [self dismissViewControllerAnimated:YES completion:^{
                            
                        }];
                   
                }];
                //创建操作
                UIAlertAction * backAlertAction = [UIAlertAction actionWithTitle:@"不登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        self.uesrName.text = @"";
                        self.password.text = @"";
                    
                }];
                //加入操作表
                [controller addAction:alertAction];
                [controller addAction:backAlertAction];
                //显示操作表
                [self presentViewController:controller animated:YES completion:nil];
                break;
            }else{
                //查找到的数据和用户输入的用户名和密码不符合
                UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"⚠️" message:@"账户名或密码不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                [alertView show];

            }
        }
       
    }else{
        //没有数据说明用户名为空
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"⚠️" message:@"账户为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alertView show];
    }

   
    
}

- (IBAction)registerNextPage:(id)sender {
    
    UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //从故事板中获取视图
    RegisterViewController * registerControll = [story instantiateViewControllerWithIdentifier:@"1"];
    //将视图作为模态视图推出
    [self presentViewController:registerControll animated:YES completion:^{
        
    }];
    

    
}
- (IBAction)back:(id)sender {
    //把模态视图从栈中移除
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}


@end
