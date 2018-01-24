//
//  ViewController.m
//  textAndImage
//
//  Created by hardy on 2018/1/22.
//  Copyright © 2018年 Hardy Hu. All rights reserved.
//

#import "ViewController.h"
#import "HTEmojHelp.h"

@interface ViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIView *showTextView;
@property (weak, nonatomic) IBOutlet UITextView *sView;


@property (nonatomic, copy) NSString *str;

@end

@implementation ViewController

- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"%@",textView.text);
    
    NSString *str = [HTEmojHelp encodeEmoj:textView.text];
    
    self.str = str;
    
    NSLog(@"%@",str);
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"%@",textView.text);
    
    NSString *str = [HTEmojHelp encodeEmoj:textView.text];
    
    NSLog(@"%@",str);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.textView.delegate = self;


    NSLog(@"%@",self.textView);
    
    
    UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
    sender.frame = CGRectMake(10, 300, 200, 30);
    [sender setTitle:@"我是按钮" forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [sender addTarget:self action:@selector(senderClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sender];
    
//    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"1234"];
//    [attStr addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[UIColor orangeColor].CGColor range:NSMakeRange(0, attStr.length)];
//
//    _zpView = [[ZHPCoreTextView alloc] initWithFrame:CGRectMake(100, 100, self.view.frame.size.width/2, self.view.frame.size.height/2) text:@"什么时候变得不安，和没有归属感。然后还一味任性地埋怨，这不是我的错，如此焦躁，和孩子气的自己。忍不住的想放逐和流浪。看着依旧苍白的自己，像蒲草一样飘来飘去" imageNameArray:@[@"保.jpg",@"搬.jpg",@"票.jpg"] delegate:self];
//    _zpView.backgroundColor = [UIColor whiteColor];
//    _zpView.center = self.view.center;
//    [self.view addSubview:_zpView];
    
    
    
}
////通过代理方法获得段落的高度
//- (void)viewHeight:(CGFloat)height{
//
//    NSLog(@"段落高度为：%f",height);
//
//}

- (void)senderClick:(id)sender
{
    NSString *showStr = [HTEmojHelp decodeEmoj:self.str];
    self.sView.text =  showStr;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
