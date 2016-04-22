//
//  CustomView.h
//  CommunicationProject
//
//  Created by Mac on 16/3/3.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "People.h"
@interface CustomView : UIView
- (id)initFrame:(CGRect)frame withPeople:(People *)p;//由于以前传值的时候需要几个参数，咱们在定义方法的时候就要给它写几个参数，这样太麻烦，所以把这些参数放在一个对象里面，这样的话只传一个参数就OK了


@end
