//
//  SearchViewController.h
//  CommunicationProject
//
//  Created by Mac on 16/3/3.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UISearchResultsUpdating>
@property (retain, nonatomic) IBOutlet UITableView *searchTableView;
@property(nonatomic,retain) NSArray *dataArr;
@end
