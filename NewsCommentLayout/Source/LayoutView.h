//
//  LayoutView.h
//  CommentLaout
//
//  Created by xiaohaibo on 11/29/15.
//  Copyright © 2015 xiaohaibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
@class LayoutContainerView;
@interface LayoutView : UIView
@property(nonatomic,assign)BOOL isLastFloor;
@property(nonatomic,assign)LayoutContainerView *container;
- (instancetype)initWithFrame:(CGRect)frame andInfo:(CommentModel *)info andParentView:(LayoutView *)p isLast:(BOOL)isLast;
@end
