//
//  SearchViewController.m
//  CommunicationProject
//
//  Created by Mac on 16/3/3.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "SearchViewController.h"
#import "ChatViewController.h"
@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)NSMutableArray *dataArray;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // _dataArray=[[NSMutableArray alloc] init];
    
    _searchTableView.backgroundColor=[UIColor clearColor];
 //   self.dataArray=[NSMutableArray array];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSArray *array=[[NSUserDefaults standardUserDefaults] objectForKey:@"data"];
    NSPredicate *predict=[NSPredicate predicateWithFormat:@"SELF contains [cd] %@",searchController.searchBar.text];
    self.dataArray=(NSMutableArray *)[array filteredArrayUsingPredicate:predict];
  //  _dataArray=[(NSMutableArray *)[array filteredArrayUsingPredicate:predict] retain];
// //  NSString *resultStr=[resultArr componentsJoinedByString:@" "];
//    self.dataArray=[NSMutableArray arrayWithArray:resultArr];
//    NSLog(@"++++++%@",_dataArray);
//    [_dataArray removeAllObjects];
//    for (NSString *name in self.dataArr) {
//        [_dataArray addObject:name];
//        NSLog(@"++++++%@",self.dataArr);
        [_searchTableView reloadData];
//    }
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"] autorelease];
    }
    cell.backgroundColor=[UIColor clearColor];
    NSDictionary *dic=_dataArray[indexPath.row] ;
    cell.textLabel.text=dic[@"UName"];
  //  cell.textLabel.text=_dataArray[indexPath.row] ;
    return cell;
}
#pragma mark---点击行时的触发方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatViewController *chatVC=[[ChatViewController alloc] init];
    NSDictionary *dic=_dataArray[indexPath.row];
    chatVC.title=dic[@"UName"];
    [self.navigationController pushViewController:chatVC animated:YES];
    [chatVC release];
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
    [_dataArray release];
    [_searchTableView release];
    [super dealloc];
}
@end
