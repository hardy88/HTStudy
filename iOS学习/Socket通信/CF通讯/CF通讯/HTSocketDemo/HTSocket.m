//
//  HTSocket.m
//  CF通讯
//
//  Created by hardy on 16/9/1.
//  Copyright © 2016年 hardy. All rights reserved.
//

#import "HTSocket.h"

// BSD socket库
#import <sys/socket.h>

#import <netinet/in.h>
#import <arpa/inet.h>




typedef void(^myBlock)(id response);

@interface HTSocket ()
{
    CFSocketRef _socket;
    myBlock call;
}

@end

@implementation HTSocket


+ (instancetype)manager
{
    static  HTSocket *socketManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       socketManager = [[HTSocket alloc] init];
    });
    return socketManager;
}

- (void)url:(NSString*)url
       port:(NSString*)port
     method:(NSString*)method
    message:(NSString*)message
   callBack:(void(^)(id response))callback
{
     call = callback;
    [self createSocktWithIp:url Port:port];
    [self method:method message:message callBack:callback];
}

- (void)url:(NSString*)url
     method:(NSString*)method
    message:(NSString*)message
   callBack:(void(^)(id response))callback
{
     call = callback;
    [self createSocktWithIp:url Port:@"80"];
    [self method:method message:message callBack:callback];
}


-(void)createSocktWithIp:(NSString*)ip Port:(NSString *)port
{
    _socket = CFSocketCreate(kCFAllocatorDefault, PF_INET, SOCK_STREAM, IPPROTO_TCP, kCFSocketNoCallBack, nil, NULL);
    if (_socket != nil)
    {
        struct sockaddr_in addr4;
        memset(&addr4, 0, sizeof(addr4));
        addr4.sin_len = sizeof(addr4);
        addr4.sin_family = AF_INET;
        const char *host = [ip UTF8String];
        addr4.sin_addr.s_addr = inet_addr(host);
        NSInteger hostPort = [port integerValue];
        addr4.sin_port = htons(hostPort);
        
        CFDataRef address = CFDataCreate(kCFAllocatorDefault, (UInt8 *)&addr4, sizeof(addr4));
        
        CFSocketError result =  CFSocketConnectToAddress(_socket, address, 15);
        
        if (result == kCFSocketSuccess)
        {
             NSLog(@"socket连接成功 ----》");
            
            [NSThread detachNewThreadSelector:@selector(readStream) toTarget:self withObject:nil];
        }
        else
        {
            NSLog(@"socket连接失败");
            call(@"socket连接失败");
        }
    }
    else
    {
        NSLog(@"socket创建失败");
         call(@"socket创建失败");
    }
}


- (void)method:(NSString*)method
       message:(NSString*)message
      callBack:(void(^)(id response))callback
{
   
    NSString *methodStr = [self sendMessageMethod:method];
    NSString *body = [self sendMethod:methodStr body:message];
    
    NSString *str = body;
    const char *data = [str UTF8String];
    [self sendSocketData:data];
}

- (NSString*)sendMessageMethod:(NSString*)message
{
    NSString *methodStr = @"{method=";
    return [methodStr stringByAppendingString:message];
}

- (NSString*)sendMethod:(NSString*)method body:(NSString*)message
{
   NSString *body = [method stringByAppendingString:@",body="];
   NSString *bodyStr = [body stringByAppendingString:message];
   return [bodyStr stringByAppendingString:@"}"];
}

-(void)readStream
{
    char buffer[2048];
    long hasRead;
    
    hasRead = recv(CFSocketGetNative(_socket), buffer, sizeof(buffer), 0);
    while (hasRead)
    {
        NSString *str = [[NSString alloc] initWithBytes:buffer length:hasRead encoding:NSUTF8StringEncoding];
        call(str);
        if (str)
        {
            close(CFSocketGetNative(_socket));
        }
        return;
    }
}

- (void)sendSocketData:(const char*)data
{
    
     send(CFSocketGetNative(_socket), data, strlen(data)+1, 1);
}

@end
