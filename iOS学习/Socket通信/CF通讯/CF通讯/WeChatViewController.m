//
//  WeChatViewController.m
//  CF通讯
//
//  Created by hardy on 2017/2/9.
//  Copyright © 2017年 hardy. All rights reserved.
//

#import "WeChatViewController.h"
#import "HTSocket.h"

@interface WeChatViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tbView;
}
@end

@implementation WeChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self performSelector:@selector(startRequest) withObject:nil afterDelay:5];
    

    tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) style:UITableViewStylePlain];
    tbView.delegate = self;
    tbView.dataSource = self;
    [self.view addSubview:tbView];
}


- (void)startRequest
{
    
    // 主线程中执行
//    [self registe];
//    [self login];
    
    
        // 创建线程后自己启动
    // 如果需要获取所起的线程信息 需要在 selector中 调用 currentThread 方法
    // 需要自己管理线程信息
    // 当多线程访问同一个资源时，容易引发数据错乱和数据安全
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(registe) object:nil];
    // 需要手动启动线程
    [thread start];
    
    // detach 时创建线程后就会自己开始
    [NSThread detachNewThreadSelector:@selector(login) toTarget:self withObject:nil];
    
    

    
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(registe) object:nil];
    [op start];
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(login) object:nil];
    [op1 start];
    
    
 
}

- (void)registe
{
    
    NSLog(@"注册 %@",  [NSThread currentThread]);
    
    HTSocket *manager = [[HTSocket alloc] init];
    
    [manager url:@"192.168.1.181"
            port:@"30000"
          method:@"ht_register"
         message:@"你好，我要注册"
        callBack:^(id response) {
            
            NSLog(@"注册信息：%@",response);
            
        }];
}

- (void)login
{
      NSLog(@"登录  %@",  [NSThread currentThread]);
    
    HTSocket *socket = [[HTSocket alloc] init];
    
    [socket url:@"192.168.1.181"
           port:@"30000"
         method:@"ht_login"
        message:@"你好，我要登录"
       callBack:^(id response) {
           
           NSLog(@"登录信息：%@",response);
           
       }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idForCell = @"UITableviewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idForCell];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idForCell];
    }
    return  cell;
}

@end
