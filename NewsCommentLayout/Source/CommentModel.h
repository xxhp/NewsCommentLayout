//
//  CommentModel.h
//  CommentLaout
//
//  Created by xiaohaibo on 11/29/15.
//  Copyright © 2015 xiaohaibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommentModel : NSObject

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *comment;
@property(nonatomic,strong)NSString *timeString;
@property(nonatomic,strong)NSString *floor;


-(instancetype)initWithDic:(NSDictionary *)dic;
-(CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
@end
