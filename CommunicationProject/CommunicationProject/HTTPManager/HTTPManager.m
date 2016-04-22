//
//  HTTPManager.m
//  CommunicationProject
//
//  Created by Mac on 16/3/2.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "HTTPManager.h"

@implementation HTTPManager
#pragma mark---注册
+ (void)getURLWithRegister:(NSString *)name  withRegisterPass:(NSString *)password{
     NSString *URLStr=@"http://172.16.11.158:8080/api/register";
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    NSData *nameData=[name dataUsingEncoding:NSUTF8StringEncoding];
    NSString *resultName= [nameData base64EncodedString];
    NSData *passData=[password dataUsingEncoding:NSUTF8StringEncoding];
    NSString *resultPass=[passData base64EncodedString];
    NSDictionary *userDic=@{@"Name":resultName,@"Password":resultPass};
    NSDictionary *resultDic=@{@"flag":@"0",@"user":userDic};
     [manager POST:URLStr parameters:resultDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
    NSLog(@"register---%@",operation.responseString);
     NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
         NSString *dec=dic[@"Dec"];
         [[NSUserDefaults standardUserDefaults]  setObject:dec forKey:@"dec"];
//         NSString *returnInfo=dic[@"ReturnInfo"];
//         [[NSUserDefaults standardUserDefaults] setObject:returnInfo forKey:@"returnInfo"];
     } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
       
   }];
}
#pragma mark---登录
+ (void)getURLWithLogin:(NSString *)name withLoginPass:(NSString *)password{
    NSString *URLStr=@"http://172.16.11.158:8080/api/login";
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    NSData *nameData=[name dataUsingEncoding:NSUTF8StringEncoding];
    NSString *resultName= [nameData base64EncodedString];
    NSData *passData=[password dataUsingEncoding:NSUTF8StringEncoding];
    NSString *resultPass=[passData base64EncodedString];
    NSDictionary *userDic=@{@"Name":resultName,@"Password":resultPass};
    NSDictionary *resultDic=@{@"flag":@"0",@"user":userDic};
    [manager POST:URLStr parameters:resultDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"login----%@",operation.responseString);
        NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
        NSString *token=dic[@"Token"];
      //  NSData *tokenData=[token dataUsingEncoding:NSUTF8StringEncoding];
       // NSString *tokenR=[tokenData base64EncodedString];
        [[NSUserDefaults standardUserDefaults]  setObject:token forKey:@"token"];
        NSLog(@"%@",NSHomeDirectory());
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];

}
#pragma mark---获取头像

+ (void)getHeaderImageWithURLStr:(NSString *)URLStr{
    NSString *string=@"http://172.16.11.158:8080/api/upload?token=";
    //NSString *URLString=[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *URLString=[string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/plain"];
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [manager POST:URLString parameters:@{@"token":token} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        UIImage *image=[UIImage imageNamed:URLStr];
        NSData *data=UIImageJPEGRepresentation(image, 0.1);
      //  NSString *path=[[NSBundle mainBundle] pathForResource:@"IMG_6367" ofType:@"jpg"];
       // [formData appendPartWithFileURL:[NSURL URLWithString:path] name:@"file" error:nil];
      //  NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:URLStr]];
      //  [formData appendPartWithHeaders:@{@"file":@"Content-Disposition"} body:data];
        [formData appendPartWithFileData:data name:@"file" fileName:@"mm" mimeType:@"jpg"];
      
           } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
           NSLog(@"image----%@",operation.responseString);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"image----%@",operation.responseString);
    }];
  }

#pragma mark---获取好友信息
//+ (void)getFriendInfo:(void(^)(NSArray *array))myBlock{
+ (void)getFriendInfo{
  //  NSString *URLStr=[NSString stringWithFormat:@"http://172.16.11.158:8080/api/update/userinfo?token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    NSString *URLStr=@"http://172.16.11.158:8080/api/update/userinfo";
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager POST:URLStr parameters:@{@"token":token} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"friendInfo----%@",operation.responseString);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
//    if (myBlock) {
//        myBlock(array);
//    }
}

#pragma mark---获取好友列表
+ (void)getFriendQueue:(void(^)(NSArray *array))queueBlock{
//+ (void)getFriendQueue{
    NSString *URLStr=[NSString stringWithFormat:@"http://172.16.11.158:8080/api/friends?token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
   // NSString *string=[URLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *string=[URLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet ]];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager GET:string parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"friendQueue----%@",operation.responseString);
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
        NSArray *tempArr=dic[@"Users"];
       // NSLog(@"%@",tempArr);
        if (queueBlock) {
            queueBlock(tempArr);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}

#pragma mark---获取好友聊天信息
//+ (void)getFriendChatWithMes:(NSString *)mes withSrc:(NSString *)src withDes:(NSString *)des{
+ (void)getFriendChatWithMes:(NSString *)mes withSrc:(NSString *)src withDes:(NSString *)des returnInfo:(void(^)(NSDictionary*mesDic))chatInfo{
    NSString *URLStr=@"http://172.16.11.158:8080/api/friends/chat";
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    NSData *mesData=[mes dataUsingEncoding:NSUTF8StringEncoding];
    NSString *resultMes=[mesData base64EncodedString];
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
//    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
//    NSData *tokenData=[tokenStr dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *token=[tokenData base64EncodedString];
    NSData *srcData=[src dataUsingEncoding:NSUTF8StringEncoding];
    NSString *resultSrc=[srcData base64EncodedString];
    NSData *desData=[des dataUsingEncoding:NSUTF8StringEncoding];
    NSString *resultDes=[desData base64EncodedString];
    NSDictionary *userDic=@{@"src":resultSrc,@"des":resultDes};
    NSDictionary *resultDic=@{@"mes":resultMes,@"token":token,@"users":userDic};
    [manager POST:URLStr parameters:resultDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"chat---%@",operation.responseString);
        NSMutableDictionary *tempDic=[NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *fromArr=tempDic[@"MseFrom"];
        NSMutableArray *toArr=tempDic[@"MseTo"];
        NSDictionary  *resultDic=@{@"MseFrom":fromArr,@"MseTo":toArr};
       // NSDictionary *toDic=@{};
        if (chatInfo) {
            chatInfo(resultDic);
        }
      //                     NSLog(@"chatInfo----%@",resultDic);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}

#pragma mark---用户退出
+(void)exitURL{
    NSString *URLStr=[NSString stringWithFormat:@"http://172.16.11.158:8080/api/exit?token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager GET:URLStr parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"exit----%@",operation.responseString);
      //  NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
           [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"token"];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}

#pragma mark---用户商店
//+ (void)salerStore{
+ (void)salerStore:(void(^)(NSArray *array))myBlock{
    NSString *URLStr=[NSString stringWithFormat:@"http://172.16.11.158:8080/api/home/data?token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager GET:URLStr parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
       // NSLog(@"store---%@",operation.responseString);
        NSDictionary *jsonDic=[NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic=jsonDic[@"data"];
        NSArray *arr=dataDic[@"items"];
        if (myBlock) {
            myBlock(arr);
        }
        NSLog(@"********%@",arr);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}





@end
