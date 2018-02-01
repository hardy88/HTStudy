//
//  ViewController.m
//  UITextViewDemo
//
//  Created by hardy on 2018/1/31.
//  Copyright © 2018年 Hardy Hu. All rights reserved.
//

#import "ViewController.h"
//#import "UIViewController+HTUITextField.h"
#import "UITextField+Extension.h"


@interface ViewController ()<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tFiled;
@property (weak, nonatomic) IBOutlet UITextView *tView;
@property (weak, nonatomic) IBOutlet UILabel *showCountLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tFiled.delegate = self;
    [self.tFiled textFieldDidChange];
    
}




// 是否改变输入的字符
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) // 如果输入了回车就直接退出
    {
        [self.tFiled resignFirstResponder];
        return NO;
    }
    return  YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(nonnull NSString *)text
{
    if ([text isEqualToString:@"\n"]) // 如果输入了回车就直接退出
    {
        [self.tView resignFirstResponder];
        return NO;
    }
    return  YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    textView.text = nil;
    return  YES;
}

// 监听输入完成时
- (void)textViewDidChange:(UITextView *)textView
{
    static  NSUInteger MINVALUE = 10;
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos)
    {
        return;
    }
    NSUInteger count = textView.text.length;
    NSLog(@"%@",[NSString stringWithFormat:@"%ld/%ld字", (unsigned long)count,(unsigned long) MINVALUE]);
    self.showCountLabel.text = [NSString stringWithFormat:@"%ld/%ld字", (unsigned long)count,(unsigned long) MINVALUE];
}

@end
