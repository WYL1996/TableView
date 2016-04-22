//
//  HTTPManager.h
//  CommunicationProject
//
//  Created by Mac on 16/3/2.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"
#import "NSData+Base64.h"
@interface HTTPManager : NSObject
//@property(nonatomic,copy)void(^myBlock)(NSString *);
+ (void)getURLWithRegister:(NSString *)name  withRegisterPass:(NSString *)password;//注册界面的URL

+ (void)getURLWithLogin:(NSString *)name withLoginPass:(NSString *)password;//登录界面的URL

+ (void)getHeaderImageWithURLStr:(NSString *)URLStr;//上传用户图片

//+ (void)getFriendInfo:(void(^)(NSArray *array))myBlock;//获取好友信息
+ (void)getFriendInfo;

+ (void)getFriendQueue:(void(^)(NSArray *array))queueBlock;//获取好友列表
//+ (void)getFriendQueue;

//+ (void)getFriendChatWithMes:(NSString *)mes withSrc:(NSString *)src withDes:(NSString *)des;//获取好友聊天信息
+ (void)getFriendChatWithMes:(NSString *)mes withSrc:(NSString *)src withDes:(NSString *)des returnInfo:(void(^)(NSDictionary*mesDic))chatInfo;

+(void)exitURL;//用户退出

//+ (void)salerStore;//用户商店
+ (void)salerStore:(void(^)(NSArray *array))myBlock;
@end
