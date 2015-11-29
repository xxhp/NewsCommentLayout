//
//  LayoutView.h
//  CommentLaout
//
//  Created by zhongjunchi on 11/27/15.
//  Copyright © 2015 launch10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
@class LayoutContainnerView;
@interface LayoutView : UIView
@property(nonatomic,assign)BOOL isLastFloor;
@property(nonatomic,assign)LayoutContainnerView *container;
- (instancetype)initWithFrame:(CGRect)frame andInfo:(CommentModel *)info andParentView:(LayoutView *)p isLast:(BOOL)isLast;
@end
