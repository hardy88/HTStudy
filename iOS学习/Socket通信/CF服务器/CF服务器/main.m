//
//  main.m
//  CF服务器
//
//  Created by hardy on 16/8/31.
//  Copyright © 2016年 hardy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <sys/socket.h>
#import <arpa/inet.h>



CFReadStreamRef iStream;
CFWriteStreamRef oStream;

// 读取数据
void readCallBackStream(CFReadStreamRef iStream, CFStreamEventType eventType, void *clientCallBackInfo)
{
    UInt8 buff[2048];
    CFIndex hasRead = CFReadStreamRead(iStream, buff, 2048);
    if (hasRead > 0)
    {
        buff[hasRead] = '\0';
        // 收到的都是2进制数据
        printf("接收到数据: %s\n",buff);
        
    
        NSString *str_From_buff = [NSString stringWithCString:(char*)buff encoding:NSUTF8StringEncoding];
        
        if ([str_From_buff containsString:@"method=ht_login"])
        {
           const char *str = "登录成功";
           CFWriteStreamWrite(oStream, (UInt8 *)str, strlen(str) + 1);
        }
        else if([str_From_buff containsString:@"method=ht_register"])
        {
            const char *str = "注册成功";
            CFWriteStreamWrite(oStream, (UInt8 *)str, strlen(str) + 1);
        }
        else if([str_From_buff containsString:@"method=ht_sendMessage"])
        {
            const char *str = "发送信息成功";
            CFWriteStreamWrite(oStream, (UInt8 *)str, strlen(str) + 1);
        }
        else
        {
            const char *str = "没有此函数方法";
            CFWriteStreamWrite(oStream, (UInt8 *)str, strlen(str) + 1);
        }
    }
}

// 有客户端连接进来的回调函数
// 回调函数，  函数名可以任意取，但是参数是固定的
void TCPServerAcceptCallBack(CFSocketRef socket, CFSocketCallBackType type, CFDataRef address, const void* data, void* info)
{
    NSLog(@"有客户端进来");
    if (kCFSocketAcceptCallBack == type)
    {
        CFSocketNativeHandle nativeSocketHandle = *(CFSocketNativeHandle*)data;
        uint8_t name[SOCK_MAXADDRLEN];
        socklen_t nameLen = sizeof(name);
        if (getpeername(nativeSocketHandle, (struct sockaddr*)name, &nameLen) != 0)
        {
            NSLog(@"error");
            exit(1);
        }
        
        // 获取连接信息
//        struct sockaddr_in *addr_in = (struct sockaddr_in*) name;
        

        
        // 创建一个可读写的Socket连接
        CFStreamCreatePairWithSocket(kCFAllocatorDefault, nativeSocketHandle, &iStream, &oStream);
        
        if (iStream && oStream)
        {
            CFReadStreamOpen(iStream);
            CFWriteStreamOpen(oStream);
            CFStreamClientContext streamContext = {0,NULL,NULL,NULL};
            BOOL isCreat = CFReadStreamSetClient(iStream, kCFStreamEventHasBytesAvailable, readCallBackStream, &streamContext);
            if (!isCreat)
            {
                exit(1);
            }

                CFReadStreamScheduleWithRunLoop(iStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);

        }
        
        
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool
    {
       
        // 创建socket
        CFSocketRef _socket = CFSocketCreate(kCFAllocatorDefault,  // 分配内存
                                             PF_INET, // 协议族 ipv4 PF_INET IPV6 PF_INET6
                                             SOCK_STREAM, // 套接字类型
                                             IPPROTO_TCP, // 套接字协议
                                             kCFSocketAcceptCallBack, // 回调事件触发类型
                                             TCPServerAcceptCallBack,  // 触发时调用的函数
                                             NULL); // 用户定义数据指针
        
        if (_socket == NULL)
        {
            NSLog(@"创建SOCKET失败");
            return 0;
        }
        
        int optval = 1;
        
        // 初始化
        setsockopt(CFSocketGetNative(_socket), SOL_SOCKET, SO_REUSEADDR, (void*)&optval, sizeof(optval));
        
        struct sockaddr_in addr4;
        
        memset(&addr4, 0, sizeof(addr4));
        
        addr4.sin_len = sizeof(addr4);
        
        addr4.sin_family = AF_INET;
        // 设置该服务器监听本机任意可用的IP地址
//         addr4.sin_addr.s_addr = htonl(INADDR_ANY);
        
        // 设置服务器监听地址
        addr4.sin_addr.s_addr = inet_addr("192.168.1.181");
        
        addr4.sin_port = htons(30000);
        
        CFDataRef address = CFDataCreate(kCFAllocatorDefault, (UInt8 *)&addr4, sizeof(addr4));
        
        if (CFSocketSetAddress(_socket, address) != kCFSocketSuccess)
        {
         
            NSLog(@"地址绑定失败");
            if (_socket)
            {
                CFRelease(_socket);
                exit(1);
            }
            _socket = NULL;
        }
        
        NSLog(@"----启动循环监听客户端连接----");
        
        // 获取当前线程
        CFRunLoopRef cfRunLoop = CFRunLoopGetCurrent();
        
        CFRunLoopSourceRef source = CFSocketCreateRunLoopSource(kCFAllocatorDefault, _socket, 0);
        
        CFRunLoopAddSource(cfRunLoop, source, kCFRunLoopCommonModes);
        
        CFRelease(source);
        
        // 运行当前线程
        CFRunLoopRun();
        
        
    }
    return 0;
}

