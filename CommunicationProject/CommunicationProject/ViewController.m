//
//  ViewController.m
//  CommunicationProject
//
//  Created by Mac on 16/3/2.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "ViewController.h"
#import "RegisterViewController.h"
#import "HTTPManager.h"
#import "MainViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark---登录按钮的点击事件
- (IBAction)loginButtonClick:(UIButton *)sender {
   // [HTTPManager getURLWithLogin:[[NSUserDefaults standardUserDefaults] objectForKey:@"name"]  withLoginPass:[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]];
    [HTTPManager getURLWithLogin:_nameTextField.text withLoginPass:_passwordTextField.text];
    if (![_nameTextField.text isEqualToString:@""]&&![_passwordTextField.text isEqualToString:@""]) {
        MainViewController *mainVC=[[MainViewController alloc] init];
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:mainVC];
        self.view.window.rootViewController=nav;
    }
    
    
   

}

#pragma mark---注册按钮的点击事件
- (IBAction)registerButtonClick:(UIButton *)sender {
    RegisterViewController *registerVC=[[RegisterViewController alloc] init];
    [self presentViewController:registerVC animated:YES completion:^{
        [registerVC release];
    }];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_topLabel release];
    [_nameTextField release];
    [_passwordTextField release];
    [super dealloc];
}
@end
