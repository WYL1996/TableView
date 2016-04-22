//
//  People.h
//  CommunicationProject
//
//  Created by Mac on 16/3/3.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface People : NSObject
@property(nonatomic,retain)NSString *text;//这个属性是用来装人物说的话的
@property(nonatomic,assign)CGSize textSize;//这个属性是来装聊天的内容的大小的，方便后面做label自适应的

//@property(nonatomic,assign) BOOL isMe;//这个属性用来判断是否是自己说的话
@end
