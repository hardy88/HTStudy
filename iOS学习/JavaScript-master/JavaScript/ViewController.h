//
//  ViewController.h
//  JavaScript


#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController : UIViewController<UIWebViewDelegate>
@property (nonatomic, strong) JSContext *jsContext;
@property (strong, nonatomic)  UIWebView *webView;

@end

