//
//  CommentModel.h
//  CommentLaout
//
//  Created by zhongjunchi on 11/28/15.
//  Copyright © 2015 launch10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class LayoutView;
@interface CommentModel : NSObject

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *comment;
@property(nonatomic,strong)NSString *timeString;
@property(nonatomic,strong)NSString *floor;
@property(nonatomic,assign)CGFloat textHeight;
@property(nonatomic,assign)CGRect frame;
@property(nonatomic,assign)LayoutView *view;
-(instancetype)initWithDic:(NSDictionary *)dic;
@end
