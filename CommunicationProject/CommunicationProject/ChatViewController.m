//
//  ChatViewController.m
//  CommunicationProject
//
//  Created by Mac on 16/3/2.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "ChatViewController.h"
#import "HTTPManager.h"
#import "NSData+Base64.h"
#import "People.h"
#import "CustomView.h"
@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIToolbar *_toolBar;
    NSMutableArray *_dataArray;
    UITextField *_textField;
}
@property(nonatomic,retain)NSMutableArray *fromArray;
@property(nonatomic,retain)NSMutableArray *toArray;
@end

@implementation ChatViewController
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden=YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _chatTableView.backgroundColor=[UIColor clearColor];
    _dataArray=[[NSMutableArray alloc] init];
    
    [self creatButtonView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
    }
    cell.backgroundColor=[UIColor clearColor];
    // 先把原来cell上面的view给移除掉，然后再添加新的  subviews这个属性里面装的是子视图
    NSArray *array= cell.contentView.subviews;
    for (UIView*vi  in array) {
        [vi removeFromSuperview];//把cell的contentView上面所有的子视图从父类上面移除
    }
    People *p=_dataArray[indexPath.row];
    //cell.textLabel.text=p.text;
    CustomView *cV=[[CustomView alloc] initFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100) withPeople:p];
    [cell.contentView addSubview:cV];
    return cell;
}
#pragma mark---创建类似于qq下面输入聊天内容的工具栏
- (void)creatButtonView{
    _toolBar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 676, 414, 60)];
    _toolBar.backgroundColor=[UIColor redColor];
    [self.view addSubview:_toolBar];
    
    _textField=[[UITextField alloc] initWithFrame:CGRectMake(10, 10, 260, 40)];
    _textField.borderStyle=UITextBorderStyleRoundedRect;
    UIBarButtonItem *textItem=[[UIBarButtonItem alloc] initWithCustomView:_textField];
    
    UIButton *senderButton=[UIButton buttonWithType:UIButtonTypeSystem];
    senderButton.frame=CGRectMake(senderButton.viewForFirstBaselineLayout.bounds.size.width-50, 10, 80, 40);
    [senderButton setTitle:@"发送" forState:UIControlStateNormal];
    [senderButton addTarget:self action:@selector(senderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *senderButtonItem=[[UIBarButtonItem alloc] initWithCustomView:senderButton];
    _toolBar.items=@[textItem,senderButtonItem];//items是一个数组，里面装UIBarButtonItem类型的对象的数组

}
#pragma mark---发送按钮的点击事件
- (void)senderButtonClick:(UIButton *)sender{
   // [HTTPManager getFriendChatWithMes:_textField.text withSrc:@"55552222@qq.com" withDes:@"54123@qq.com"];
//    [HTTPManager getFriendChatWithMes:_textField.text withSrc:@"55552222@qq.com" withDes:self.title];
    [HTTPManager getFriendChatWithMes:_textField.text  withSrc:@"55552222@qq.com"  withDes:self.title returnInfo:^(NSDictionary *mesDic) {
        NSLog(@"chatInfo-------%@",mesDic);
        NSMutableDictionary *resultDic=[[NSMutableDictionary alloc] initWithDictionary:mesDic];
        
    }];

    People *p=[[People alloc] init];
    p .text=_textField.text;
    CGRect  rect= [p.text boundingRectWithSize:CGSizeMake(200, 100000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];//计算出输入的文字的宽高，方便下面用
    p.textSize=rect.size;
    //到此为止，p对象初始化完成并且给它的属性也赋完值了
    [_dataArray addObject:p];//以前直接把字符串放数组里面，现在由于要放两个东西，所以把对象p放数组，相当于找了一个盒子，把盒子放数组里面，盒子里面放的是即将用的数据
    [_chatTableView reloadData];
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:_dataArray.count-1 inSection:0];
    [_chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    _textField.text=@"";

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    People *p=_dataArray[indexPath.row];
    return p.textSize.height+50;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_chatTableView release];
    [super dealloc];
}
@end
