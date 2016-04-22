//
//  CustomView.m
//  CommunicationProject
//
//  Created by Mac on 16/3/3.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (id)initFrame:(CGRect)frame withPeople:(People *)p{
    self=[super init];
    if (self) {
        CGFloat  width=[UIScreen mainScreen].bounds.size.width;
        // CGFloat  height=[UIScreen mainScreen].bounds.size.height;
        UIImageView *headerImageView=[[UIImageView alloc] initWithFrame:CGRectMake(width-60, 70,50, 50)];
        headerImageView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1049687624,2977992633&fm=116&gp=0.jpg"]]];
        headerImageView.layer.cornerRadius=25;
        headerImageView.clipsToBounds=YES;
        [self addSubview:headerImageView];
        
        //UIImageView *chatImageView=[[UIImageView alloc] initWithFrame:CGRectMake(width-headerImageView.bounds.size.width-220, headerImageView.bounds.size.height-50, 200, p.textSize.height +40)];
        UIImageView *chatImageView=[[UIImageView alloc] initWithFrame:CGRectMake(width-headerImageView.bounds.size.width-220, 70, 200, p.textSize.height +40)];
        chatImageView.image=[UIImage imageNamed:@"rightBubble2.png"];
        [self addSubview:chatImageView];
        
        UILabel *textLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, chatImageView.bounds.size.width-40, chatImageView.bounds.size.height-40)];
        textLabel.text=p.text;
        textLabel.numberOfLines=0;
        textLabel.font=[UIFont systemFontOfSize:17];
        [chatImageView addSubview:textLabel];
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
   
@end
