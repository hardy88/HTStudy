//
//  ViewController.m
//  JavaScript


#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Demo" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [self.webView loadRequest:request];
    
    UIButton *ocBut = [UIButton buttonWithType:UIButtonTypeCustom];
    ocBut.backgroundColor = [UIColor greenColor];
    ocBut.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.height - 80, [UIScreen mainScreen].bounds.size.width - 20, 30);
    [ocBut setTitle:@"OC调用JS方法" forState:UIControlStateNormal];
    [ocBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ocBut addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ocBut];
    
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
    
    // 监听JS按钮事件的回调
    self.jsContext[@"callBackToOC"] =^{
        NSArray *arg = [JSContext currentArguments];
        for (id obj in arg)
        {
             NSLog(@"%@",obj);
        }
    };
}

- (void)butClick:(UIButton *)sender
{
    // OC调用JS里面的方法
    [self.jsContext evaluateScript:@"ocClick('OC调用JS')"];
}
@end
