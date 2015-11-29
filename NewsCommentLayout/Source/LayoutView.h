//
//  LayoutView.h
//  CommentLaout
//
//  Created by xiaohaibo on 11/29/15.
//  Copyright © 2015 xiaohaibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
 
@interface LayoutView : UIView
- (instancetype)initWithFrame:(CGRect)frame andModel:(CommentModel *)info andParentView:(LayoutView *)p isLast:(BOOL)isLast;
@end
