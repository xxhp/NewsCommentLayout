//
//  GridLayoutView.m
//  CommentLaout
//
//  Created by xiaohaibo on 11/29/15.
//  Copyright © 2015 xiao haibo. All rights reserved.
//

#import "GridLayoutView.h"
#import "Constant.h"
@implementation GridLayoutView

- (instancetype)initWithFrame:(CGRect)frame andModelArray:(NSArray *)modelArray;
{
    if (self = [super initWithFrame:frame]) {
        
        self.layer.borderWidth = LayoutBordWidth;
        self.layer.borderColor = LayoutBordColor.CGColor;
        self.backgroundColor = LayoutBackgroundColor;
        
        float lastH = 0;
        for (CommentModel *model in modelArray) {
            
            CGSize sz =[model sizeWithConstrainedToSize:CGSizeMake(self.frame.size.width-10, MAXFLOAT)];
            
            UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5+lastH,frame.size.width - 10, 34)];
            nameLabel.font = NameFont;
            nameLabel.textColor = NameColor;
            
            
            UILabel* addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            addressLabel.frame    = CGRectMake(5, 5+lastH+20,frame.size.width - 10, 34);
            addressLabel.textColor =[UIColor grayColor];
            addressLabel.font = AddressFont;
            
            UILabel*  commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, nameLabel.frame.origin.y+5+nameLabel.frame.size.height ,frame.size.width - 10, sz.height+20)];
            commentLabel.numberOfLines =0;
            commentLabel.font = CommentFont;
            
            
            UILabel* floorLabel = [[UILabel alloc] initWithFrame: CGRectMake(self.frame.size.width - 15,5+lastH ,15, 34)];
            floorLabel.font = CommentFont;
            floorLabel.textColor =[UIColor grayColor];
            
        
            nameLabel.text   = model.name;
            addressLabel.text  = model.address;
            commentLabel.text = model.comment;
            floorLabel.text = model.floor;
            
            
            [self addSubview:nameLabel];
            [self addSubview:addressLabel];
            [self addSubview:commentLabel];
            [self addSubview:floorLabel];
            
            CGRect r = CGRectMake(0,commentLabel.frame.origin.y + commentLabel.frame.size.height, self.bounds.size.width,LayoutBordWidth);
            UIView *vi =[[UIView alloc] initWithFrame:r];//分割线
            vi.backgroundColor = LayoutBordColor;
            
            if ([modelArray lastObject] != modelArray) {
                [self addSubview:vi];
            }
            lastH = r.origin.y;
        }
       
        CGRect fr = frame;
        fr.size.height = lastH;
        self.frame = fr;
    }
    return self;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
