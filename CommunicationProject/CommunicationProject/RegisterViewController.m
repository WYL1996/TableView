//
//  RegisterViewController.m
//  CommunicationProject
//
//  Created by Mac on 16/3/2.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "RegisterViewController.h"

#import "HTTPManager.h"
@interface RegisterViewController ()
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark---注册按钮的点击事件
- (IBAction)registerButtonClick:(UIButton *)sender {
    [HTTPManager getURLWithRegister:_registerNameTextField.text withRegisterPass:_registerPasswordTextField.text];
    _topLabel.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"dec"];
    [[NSUserDefaults standardUserDefaults] setObject:_registerNameTextField.text forKey:@"name"];
    [[NSUserDefaults standardUserDefaults] setObject:_registerPasswordTextField.text forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
   // if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"dec"] isEqualToString:@"注册成功!!!!!请重新登录!!!!"])  {
     //   [self dismissViewControllerAnimated:YES completion:nil];
   // }
    
}
- (IBAction)backButtonClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
   
    [_registerNameTextField release];
    [_registerPasswordTextField release];
    [_topLabel release];
    [super dealloc];
}
@end
