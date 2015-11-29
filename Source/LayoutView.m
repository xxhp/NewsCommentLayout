//
//  LayoutView.m
//  CommentLaout
//
//  Created by zhongjunchi on 11/27/15.
//  Copyright © 2015 launch10. All rights reserved.
//

#import "LayoutView.h"
#import "LayoutContainnerView.h"
#import "constant.h"
@interface LayoutView()
@property(nonatomic,strong)CommentModel *dic;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *floorLabel;
@property(nonatomic,strong)UILabel *commentLabel;
@property(nonatomic,strong)UILabel *addressLabel;
@property(nonatomic,assign)UIView *parent;

@end

@implementation LayoutView
- (CGSize)text:(NSString *)string SizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGSize textSize;
    
    
    NSDictionary *attribute = @{NSFontAttributeName: font};
    textSize = [string boundingRectWithSize:CGSizeMake(size.width, 0)
                                    options:\
                NSStringDrawingTruncatesLastVisibleLine |
                NSStringDrawingUsesLineFragmentOrigin |
                NSStringDrawingUsesFontLeading
                                 attributes:attribute
                                    context:nil].size;
    //            textSize.height = ceil(textSize.height);
    //            textSize.width = ceil(textSize.width);
    
    
    return textSize;
}
- (instancetype)initWithFrame:(CGRect)frame andInfo:(CommentModel *)info andParentView:(LayoutView *)p isLast:(BOOL)isLast
{
    if (self = [super initWithFrame:frame]) {
        self.parent = p;
        self.dic = info;
        if (!isLast) {
            self.layer.borderWidth =0.6;
            self.layer.borderColor =[UIColor colorWithRed:215./255. green:215./255 blue:191./255 alpha:1].CGColor;
            self.backgroundColor =[UIColor colorWithRed:245./255. green:245./255 blue:236./255 alpha:1];
        }
       
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        
        _commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _commentLabel.numberOfLines =0;
        _commentLabel.font =[UIFont systemFontOfSize:14];
        
        _nameLabel.text = info.name;
        _nameLabel.font =[UIFont systemFontOfSize:14];
        _commentLabel.text = info.comment;
        
        _floorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _floorLabel.font =[UIFont systemFontOfSize:12];
        _floorLabel.text = self.dic.floor;
        _floorLabel.textColor =[UIColor grayColor];
        
        _nameLabel.frame = CGRectMake(5, self.parent.frame.size.height ,self.frame.size.width - 10, 34);
        _floorLabel.frame = CGRectMake(self.frame.size.width - 15, self.parent.frame.size.height +5 ,15, 34);
        _commentLabel.frame =  CGRectMake(5, self.parent.frame.size.height+40 ,self.frame.size.width - 10,self.frame.size.height - self.parent.frame.size.height - 40);
        _nameLabel.textColor = ColorName;
       
        
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];

        _addressLabel.frame = CGRectMake(_nameLabel.frame.origin.x, self.parent.frame.size.height + 20 ,self.frame.size.width - 10, 34);
        _addressLabel.textColor =[UIColor grayColor];
        _addressLabel.text = info.address;
        _addressLabel.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:_nameLabel];
        [self addSubview:_addressLabel];
        [self addSubview:_commentLabel];
        [self addSubview:_floorLabel];
        
        if (isLast) {
            _nameLabel.hidden = YES;
            _addressLabel.hidden = YES;
            _floorLabel.hidden = YES;
            _commentLabel.frame = CGRectMake(5, self.parent.frame.size.height+5 ,self.frame.size.width - 10,self.frame.size.height - self.parent.frame.size.height - 40);
        }
        
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
