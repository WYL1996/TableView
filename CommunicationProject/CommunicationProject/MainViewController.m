//
//  MainViewController.m
//  CommunicationProject
//
//  Created by Mac on 16/3/2.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "MainViewController.h"
#import "HTTPManager.h"
#import "SetViewController.h"
#import "ChatViewController.h"
#import "SearchViewController.h"
#import "ViewController.h"
#import "StoreViewController.h"
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)NSMutableArray *dataArray;
@property(nonatomic,retain)UISearchController*searchControl;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=YES;
    _myTableView.backgroundColor=[UIColor clearColor];
    
  //  [HTTPManager getHeaderImageWithURLStr:@"http://file.qqkj.cn/upload/avatar/201410/29/21/06/544cead6390ff843.jpg%21200x200.jpg"];
   // [HTTPManager getHeaderImageWithURLStr:@"6.jpg"];
    _headerImageView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1049687624,2977992633&fm=116&gp=0.jpg"]]];
    _headerImageView.clipsToBounds=YES;
    _headerImageView.layer.cornerRadius=40;
    
    [HTTPManager getFriendInfo];
    
//    [HTTPManager getFriendQueue:^(NSArray *array) {
//        NSLog(@"----%@",array);
//    }];
  //  [HTTPManager getFriendQueue];
    [HTTPManager getFriendQueue:^(NSArray *array) {
        _dataArray=[[NSMutableArray alloc] initWithArray:array];
     //  NSLog(@"dataArray---%@",_dataArray);
        [_myTableView reloadData];
        //        self.searchControl=[[UISearchController alloc] initWithSearchResultsController:searchVC];
//        self.searchControl.searchResultsUpdater=searchVC;
//        self.searchControl.searchBar.frame=CGRectMake(0, 50, 414, 44);
//        self.myTableView.tableHeaderView=self.searchControl.searchBar;
//        [[NSUserDefaults standardUserDefaults] setObject:_dataArray forKey:@"data"];
        SearchViewController *searchVC=[[SearchViewController alloc] init];
       // searchVC.dataArr=self.dataArray;
        self.searchControl=[[UISearchController alloc] initWithSearchResultsController:searchVC];
        self.searchControl.searchResultsUpdater=searchVC;
        self.searchControl.searchBar.frame=CGRectMake(0, 50, 414, 44);
        self.myTableView.tableHeaderView=self.searchControl.searchBar;
//        [[NSUserDefaults standardUserDefaults] setObject:self.dataArray forKey:@"data"];
        [searchVC release];
    }];
    
    
    //_nameLabel.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
   // NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"name"]);
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"＊＊＊＊＊＊＊＊＊%ld",_dataArray.count);
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell"] autorelease];
    }
    cell.backgroundColor=[UIColor clearColor];
    NSDictionary *dic=_dataArray[indexPath.row] ;
    cell.textLabel.text=dic[@"UName"];


    return cell;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 60;
//}
#pragma mark---设置按钮的点击事件
- (IBAction)setButtonClick:(UIButton *)sender {
    SetViewController *setVC=[[SetViewController alloc] init];
    [self.navigationController pushViewController:setVC animated:YES];
    [setVC release];
}
#pragma mark---商家信息按钮的点击事件
- (IBAction)salerButtonClick:(UIButton *)sender {
     // [HTTPManager salerStore];
//   [HTTPManager salerStore:^(NSArray *array) {
//        NSLog(@"=====%@",array);
//    }];
  //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.taobao.com"]];

    StoreViewController *storeVC=[[StoreViewController alloc] init];
    [self.navigationController pushViewController:storeVC animated:YES];
    [storeVC release];
}
#pragma mark---点击行时的触发方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatViewController *chatVC=[[ChatViewController alloc] init];
    NSDictionary *dic=_dataArray[indexPath.row];
    chatVC.title=dic[@"UName"];
    [self.navigationController pushViewController:chatVC animated:YES];
    [chatVC release];
}
#pragma mark---退出按钮的点击事件
- (IBAction)exitButtonClick:(UIButton *)sender {
    [HTTPManager exitURL];
   // ViewController *vc=[[ViewController alloc] init];
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *vc=[sb instantiateInitialViewController];
    self.view.window.rootViewController=vc;
    //UIWindow *window=[UIApplication sharedApplication].keyWindow ;
   // window.rootViewController=vc; 
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
    [_myTableView release];
    [_headerImageView release];
    [_nameLabel release];
    [super dealloc];
}
@end
