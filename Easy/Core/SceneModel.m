//
//  SceneModel.m
//  NewEasy
//
//  Created by 朱潮 on 14-7-22.
//  Copyright (c) 2014年 zhuchao. All rights reserved.
//

#import "SceneModel.h"

@implementation SceneModel

+(id)SceneModel{
    return [[self alloc]initModel];
}

- (id)initModel{
    self = [super init];
    if(self){
        [self loadSceneModel];
    }
    return self;
}

- (void)loadSceneModel{
    self.action = [Action Action];
}

- (void)loadActive{
    self.active = NO;
    @weakify(self);
    [[RACObserve(self,active)
      filter:^BOOL(NSNumber *active) {
          return [active boolValue];
      }]
     subscribeNext:^(NSNumber *active) {
         @strongify(self);
         [self activeRequest];
         self.active = NO;
     }];
}

- (void)activeRequest{

}

- (void)handleActionMsg:(Request *)msg{
    if(msg.sending){
        NSLog(@"sending:%@",msg.op.url);
    }else if(msg.succeed){
        NSLog(@"success:%@",msg.output);
    }else if(msg.failed){
        NSLog(@"failed:%@",msg.error);
    }
}

- (void)handleProgressMsg:(Request *)msg{

}

- (void)SEND_ACTION:(Request *)req{
    if(req !=nil){
        [self.action Send:req];
    }
}

- (void)SEND_CACHE_ACTION:(Request *)req{
    [self.action readFromCache];
    [self SEND_ACTION:req];
}

- (void)SEND_NO_CACHE_ACTION:(Request *)req{
    [self.action notReadFromCache];
    [self SEND_ACTION:req];
}

@end
